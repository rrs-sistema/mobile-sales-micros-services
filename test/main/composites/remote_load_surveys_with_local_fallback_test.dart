import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/main/composites/composites.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

import '../../mocks/mocks.dart';

class RemoteLoadProductsSpy extends Mock implements RemoteLoadProducts {}

class LocalLoadProductsSpy extends Mock implements LocalLoadProducts {}

void main() {
  RemoteLoadProductsWithLocalFallback sut;
  RemoteLoadProductsSpy remote;
  LocalLoadProductsSpy local;
  List<ProductEntity> remoteProducts;
  List<ProductEntity> localProducts;

  PostExpectation mockRemoteLoadCall() => when(remote.load());

  void mockRemoteLoad() {
    remoteProducts = FakeProductsFactory.makeEntities();
    mockRemoteLoadCall().thenAnswer((_) async => remoteProducts);
  }

  void mockRemoteLoadError(DomainError error) =>
      mockRemoteLoadCall().thenThrow(error);

  PostExpectation mockLocalLoadCall() => when(local.load());

  void mockLocalLoad() {
    localProducts = FakeProductsFactory.makeEntities();
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
