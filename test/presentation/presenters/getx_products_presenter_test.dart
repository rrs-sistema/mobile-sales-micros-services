import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/ui/helpers/helpers.dart';
import '../../mocks/mocks.dart';

class LoadProductSpy extends Mock implements LoadProducts {}

void main() {
  LoadProductSpy loadProducts;
  GetxProductsPresenter sut;
  List<ProductEntity> products;

  PostExpectation mockLoadProductsCall() => when(loadProducts.load());

  void mockLoadProducts(List<ProductEntity> data) {
    products = data;
    mockLoadProductsCall().thenAnswer((_) async => products);
  }

  void mocakLoadProductsError() => mockLoadProductsCall().thenThrow(DomainError.unexpected);
  void mockAccessDeniedError() => mockLoadProductsCall().thenThrow(DomainError.accessDenied);

  setUp(() {
    loadProducts = LoadProductSpy();
    sut = GetxProductsPresenter(loadProducts: loadProducts);
    mockLoadProducts(FakeProductsFactory.makeEntities());
  });

  test('Shoul call LoadProdiucts on loadData', () async {
    await sut.loadData();

    verify(loadProducts.load()).called(1);
  });

  test('Shoul emit correct LoadProducts on loadData', () async {
    final listMock = FakeProductsFactory.makeViewModel();
    sut.productsStream.listen(expectAsync1((products) => expect(products, listMock)));

    await sut.loadData();
  });

  test('Shoul emit correct events on failure', () async {
    mocakLoadProductsError();

    sut.productsStream.listen(null,
      onError: (error, _) => expect(error, UIError.unexpected.description));

    await sut.loadData();
  });

  test('Should emit correct events on access denied', () async {
    mockAccessDeniedError();

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
