import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/presentation/presenters/presenters.dart';
import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/ui/pages/products/products.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/ui/helpers/helpers.dart';

class LoadCategorySpy extends Mock implements LoadCategories {}

void main() {
  LoadCategorySpy loadCategories;
  GetxCategoriesPresenter sut;

  List<CategoryEntity> products;

  List<CategoryEntity> mockValidData() => [
        CategoryEntity(
            id: 1002,
            description: 'Bíblia',
           ),
        CategoryEntity(
            id: 1002,
            description: 'Comentário',
      )
      ];

  PostExpectation mockLoadProductsCall() => when(loadCategories.load());

  void mockLoadProducts(List<CategoryEntity> data) {
    products = data;
    mockLoadProductsCall().thenAnswer((_) async => products);
  }

  void mocakLoadProductsError() =>
      mockLoadProductsCall().thenThrow(DomainError.unexpected);

  setUp(() {
    loadCategories = LoadCategorySpy();
    sut = GetxCategoriesPresenter(loadCategories: loadCategories);
    mockLoadProducts(mockValidData());
  });

  test('Shoul call LoadProdiucts on loadData', () async {
    await sut.loadData();

    verify(loadCategories.load()).called(1);
  });

  test('Shoul emit correct LoadCategories on loadData', () async {
    sut.categoriesStream.listen(expectAsync1((products) => expect(products, [
          CategoryViewModel(
              id: products[0].id,
              description: products[0].description,),
          CategoryViewModel(
              id: products[1].id,
              description: products[1].description,)
        ])));

    await sut.loadData();
  });

  test('Shoul emit correct events on failure', () async {
    mocakLoadProductsError();

    sut.categoriesStream.listen(null,
      onError: (error, _) => expect(error, UIError.unexpected.description));

    await sut.loadData();
  });
}
