import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/ui/pages/products/products.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/ui/helpers/helpers.dart';

class LoadProductSpy extends Mock implements LoadProducts {}

void main() {
  LoadProductSpy loadProducts;
  GetxProductsPresenter sut;
  List<ProductEntity> products;
  
  final imgUrl001 = faker.image.image();
  final imgUrl002 = faker.image.image();

  List<ProductEntity> mockValidData() => [
        ProductEntity(
            id: 1002,
            name: 'Bíblia atualizada',
            description: 'Bíblia atualizada de Almeida e Corrigida',
            imgUrl: imgUrl001,
            quantityAvailable: 8,
            createdAt: '29/07/2022 03:11:46', //DateTime.parse('2022-07-28 03:11:46'),
            price: 92.28,
            supplier:
                SupplierEntity(id: 1000, name: 'Sociedade Bíblica do Brasil'),
            category: CategoryEntity(id: 1000, description: 'Bíblia')),
        ProductEntity(
            id: 1002,
            name: 'Bíblia Pentecostal',
            description: 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
            imgUrl: imgUrl002,
            quantityAvailable: 8,
            createdAt: '28/07/2022 08:15:32',//DateTime.parse('2022-07-28 08:15:32'),
            price: 135.98,
            supplier:
                SupplierEntity(id: 1000, name: 'Sociedade Bíblica do Brasil'),
            category: CategoryEntity(id: 1000, description: 'Bíblia'))
      ];

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
    mockLoadProducts(mockValidData());
  });

  test('Shoul call LoadProdiucts on loadData', () async {
    await sut.loadData();

    verify(loadProducts.load()).called(1);
  });

  test('Shoul emit correct LoadProducts on loadData', () async {
    sut.productsStream.listen(expectAsync1((products) => expect(products, [
          ProductViewModel(
              id: products[0].id,
              name: products[0].name,
              description: products[0].description,
              imgUrl: imgUrl001,
              quantityAvailable: products[0].quantityAvailable,
              createdAt: products[0].createdAt,
              price: products[0].price,
              supplier: products[0].supplier,
              category: products[0].category),
          ProductViewModel(
              id: products[1].id,
              name: products[1].name,
              description: products[1].description,
              imgUrl: imgUrl002,
              quantityAvailable: products[1].quantityAvailable,
              createdAt: products[1].createdAt,
              price: products[1].price,
              supplier: products[1].supplier,
              category: products[1].category)
        ])));

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

}
