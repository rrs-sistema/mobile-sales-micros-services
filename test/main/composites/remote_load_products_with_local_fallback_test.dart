import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/main/composites/composites.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

import '../../data/mocks/mocks.dart';
import './../../domain/mocks/mocks.dart';


void main() {
  late RemoteLoadProductsWithLocalFallback sut;
  late RemoteLoadProductsSpy remote;
  late LocalLoadProductsSpy local;
  late List<ProductEntity> productsList;

  setUp(() {
    productsList = EntityFactory.makeProductList();
    remote = RemoteLoadProductsSpy();
    remote.mockLoad(productsList);
    local = LocalLoadProductsSpy();
    local.mockLoad(productsList);
    sut = RemoteLoadProductsWithLocalFallback(remote: remote, local: local);
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(() => remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.load();

    verify(() => local.save(productsList)).called(1);
  });

  test('Should return remote products', () async {
    final products = await sut.load();

    expect(products, productsList);
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

  test('Should return local products', () async {
    remote.mockLoadError(DomainError.unexpected);

    final products = await sut.load();

    expect(products, productsList);
  });

  test('Should throw UnexpectedError if remote and local throws', () async {
    remote.mockLoadError(DomainError.unexpected);
    local.mockLoadError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
