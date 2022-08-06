import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/main/composites/composites.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

import './../../data/mocks/mocks.dart';

void main() {
  late RemoteLoadCategoriesWithLocalFallback sut;
  late RemoteLoadCategoriesSpy remote;
  late LocalLoadCategoriesSpy local;
  late List<CategoryEntity> localCategories;

  List<CategoryEntity> mockCategories() => [
        CategoryEntity(
            id: 1002,
            description: faker.randomGenerator.string(150),),
      ];
 
  setUp(() {
    localCategories = mockCategories();
    remote = RemoteLoadCategoriesSpy();
    remote.mockLoad(localCategories);
    local = LocalLoadCategoriesSpy();
    local.mockLoad(localCategories);
    sut = RemoteLoadCategoriesWithLocalFallback(remote: remote, local: local);
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(() => remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.load();

    verify(() => local.save(localCategories)).called(1);
  });

  test('Should return remote categories', () async {
    final categories = await sut.load();

    expect(categories, localCategories);
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    remote.mockLoadError(DomainError.accessDenied);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local fetch on remote error', () async {
    remote.mockLoadError(DomainError.unexpected);

    await sut.load();

    verify(() => local.validate()).called(1);
    verify(() => local.load()).called(1);
  });

  test('Should return local categories', () async {
    remote.mockLoadError(DomainError.unexpected);

    final categories = await sut.load();

    expect(categories, localCategories);
  });

  test('Should throw UnexpectedError if remote and local throws', () async {
    remote.mockLoadError(DomainError.unexpected);
    local.mockLoadError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
