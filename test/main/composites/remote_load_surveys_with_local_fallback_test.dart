import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/main/composites/composites.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class RemoteLoadProductsSpy extends Mock implements RemoteLoadProducts {}

class LocalLoadProductsSpy extends Mock implements LocalLoadProducts {}

void main() {
  RemoteLoadProductsWithLocalFallback sut;
  RemoteLoadProductsSpy remote;
  LocalLoadProductsSpy local;
  List<ProductEntity> remoteProducts;
  List<ProductEntity> localProducts;

  List<ProductEntity> mockProducts() => [
        ProductEntity(
            id: 1002,
            name: faker.randomGenerator.string(50),
            description: faker.randomGenerator.string(150),
            imgUrl: faker.image.image(),
            quantityAvailable: faker.randomGenerator.integer(15),
            createdAt:
                '29/07/2022 03:11:46', //DateTime.parse('2022-07-28 03:11:46'),
            price: faker.randomGenerator.decimal(),
            supplier: SupplierEntity(
              id: faker.randomGenerator.integer(50),
              name: faker.randomGenerator.string(50),
            ),
            category: CategoryEntity(
              id: faker.randomGenerator.integer(50),
              description: faker.randomGenerator.string(50),
            )),
      ];

  PostExpectation mockRemoteLoadCall() => when(remote.load());

  void mockRemoteLoad() {
    remoteProducts = mockProducts();
    mockRemoteLoadCall().thenAnswer((_) async => remoteProducts);
  }

  void mockRemoteLoadError(DomainError error) =>
      mockRemoteLoadCall().thenThrow(error);

  PostExpectation mockLocalLoadCall() => when(local.load());

  void mockLocalLoad() {
    localProducts = mockProducts();
    mockLocalLoadCall().thenAnswer((_) async => localProducts);
  }

  void mockLocalLoadError() =>
      mockLocalLoadCall().thenThrow(DomainError.unexpected);

  setUp(() {
    remote = RemoteLoadProductsSpy();
    local = LocalLoadProductsSpy();
    sut = RemoteLoadProductsWithLocalFallback(remote: remote, local: local);
    mockRemoteLoad();
    mockLocalLoad();
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.load();

    verify(local.save(remoteProducts)).called(1);
  });

  test('Should return remote products', () async {
    final products = await sut.load();

    expect(products, remoteProducts);
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    mockRemoteLoadError(DomainError.accessDenied);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local fetch on remote error', () async {
    mockRemoteLoadError(DomainError.unexpected);

    await sut.load();

    verify(local.validate()).called(1);
    verify(local.load()).called(1);
  });

  test('Should return local products', () async {
    mockRemoteLoadError(DomainError.unexpected);

    final products = await sut.load();

    expect(products, localProducts);
  });

  test('Should throw UnexpectedError if remote and local throws', () async {
    mockRemoteLoadError(DomainError.unexpected);
    mockLocalLoadError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
