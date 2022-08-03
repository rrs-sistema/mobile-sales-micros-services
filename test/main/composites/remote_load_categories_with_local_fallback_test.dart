import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/main/composites/composites.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

class RemoteLoadCategoriesSpy extends Mock implements RemoteLoadCategories {}

class LocalLoadCategoriesSpy extends Mock implements LocalLoadCategories {}

void main() {
  RemoteLoadCategoriesWithLocalFallback sut;
  RemoteLoadCategoriesSpy remote;
  LocalLoadCategoriesSpy local;
  List<CategoryEntity> remoteCategories;
  List<CategoryEntity> localCategories;

  List<CategoryEntity> mockCategories() => [
        CategoryEntity(
            id: 1002,
            description: faker.randomGenerator.string(150),),
      ];

  PostExpectation mockRemoteLoadCall() => when(remote.load());

  void mockRemoteLoad() {
    remoteCategories = mockCategories();
    mockRemoteLoadCall().thenAnswer((_) async => remoteCategories);
  }

  void mockRemoteLoadError(DomainError error) =>
      mockRemoteLoadCall().thenThrow(error);

  PostExpectation mockLocalLoadCall() => when(local.load());

  void mockLocalLoad() {
    localCategories = mockCategories();
    mockLocalLoadCall().thenAnswer((_) async => localCategories);
  }

  void mockLocalLoadError() =>
      mockLocalLoadCall().thenThrow(DomainError.unexpected);

  setUp(() {
    remote = RemoteLoadCategoriesSpy();
    local = LocalLoadCategoriesSpy();
    sut = RemoteLoadCategoriesWithLocalFallback(remote: remote, local: local);
    mockRemoteLoad();
    mockLocalLoad();
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.load();

    verify(local.save(remoteCategories)).called(1);
  });

  test('Should return remote categories', () async {
    final categories = await sut.load();

    expect(categories, remoteCategories);
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

  test('Should return local categories', () async {
    mockRemoteLoadError(DomainError.unexpected);

    final categories = await sut.load();

    expect(categories, localCategories);
  });

  test('Should throw UnexpectedError if remote and local throws', () async {
    mockRemoteLoadError(DomainError.unexpected);
    mockLocalLoadError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
