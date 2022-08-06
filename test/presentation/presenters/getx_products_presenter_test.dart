import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/ui/helpers/helpers.dart';

import './../../ui/model/mocks/mocks.dart';
import './../../domain/mocks/mocks.dart';
import './../../data/mocks/mocks.dart';

void main() {
  late LoadProductsSpy loadProducts;
  late GetxProductsPresenter sut;
  late List<ProductEntity> products;

  setUp(() {
    products = EntityFactory.makeProductList();
    loadProducts = LoadProductsSpy();
    loadProducts.mockLoad(products);
    sut = GetxProductsPresenter(loadProducts: loadProducts);
  });

  test('Shoul call LoadProdiucts on loadData', () async {
    await sut.loadData();

    verify(() => loadProducts.load()).called(1);
  });

  test('Shoul emit correct LoadProducts on loadData', () async {
    final listMock = ModelFactory.makeViewModel();
    sut.productsStream.listen(expectAsync1((products) => expect(products, listMock)));

    await sut.loadData();
  });

  test('Shoul emit correct events on failure', () async {
    loadProducts.mockLoadError(DomainError.unexpected);

    sut.productsStream.listen(null,
      onError: (error, _) => expect(error, UIError.unexpected.description));

    await sut.loadData();
  });

  test('Should emit correct events on access denied', () async {
    //mockAccessDeniedError();
    loadProducts.mockLoadError(DomainError.accessDenied);

    expectLater(sut.isSessionExpiredStream, emits(true));

    await sut.loadData();
  });

/*
  test('Should go to DetailResultPage on product click', () async {
    expectLater(sut.navigateToStream, emitsInOrder([
      '/detail_result/1000',
      '/detail_result/1000'
    ]));

    sut.goToDetailResult(1000);
    sut.goToDetailResult(1000);
  });
*/
}
