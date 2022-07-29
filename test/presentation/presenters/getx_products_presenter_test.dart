import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

import 'package:delivery_micros_services/ui/pages/products/products.dart';
import 'package:delivery_micros_services/domain/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';

class GetxProductsPresenter {
  final LoadProducts loadProducts;

  final _isLoading = true.obs;
  final _products = Rx<List<ProductViewModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<ProductViewModel>> get productsStream => _products.stream;

  GetxProductsPresenter({@required this.loadProducts});

  Future<void> loadData() async {
    _isLoading.value = true;
    final products = await loadProducts.load();
    _products.value = products
        .map((product) => ProductViewModel(
              id: product.id,
              name: product.name,
              description: product.description,
              imgUrl: product.imgUrl,
              quantityAvailable: product.quantityAvailable,
              createdAt: product.createdAt,
              price: product.price,
              supplier: SupplierViewModel(
                  id: product.supplier.id, name: product.supplier.name),
              category: CategoryViewModel(
                  id: product.category.id,
                  description: product.category.description),
            ))
        .toList();
    _isLoading.value = false;
  }
}

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
            createdAt: DateTime.parse('2022-07-28 03:11:46'),
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
            createdAt: DateTime.parse('2022-07-28 08:15:32'),
            price: 135.98,
            supplier:
                SupplierEntity(id: 1000, name: 'Sociedade Bíblica do Brasil'),
            category: CategoryEntity(id: 1000, description: 'Bíblia'))
      ];

  void mockLoadProducts(List<ProductEntity> data) {
    products = data;
    when(loadProducts.load()).thenAnswer((_) async => products);
  }

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
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
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
}
