import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:delivery_micros_services/domain/usecases/usecases.dart';

class GetxProductsPresenter {
  final LoadProducts loadProducts;

  GetxProductsPresenter({@required this.loadProducts});

  Future<void> loaddata() async {
    await loadProducts.load();
  }
}

class LoadProductSpy extends Mock implements LoadProducts{}

void main() {
  test('Shoul call LoadProdiucts on loadData', () async {
    final loadProducts = LoadProductSpy();
    final sut = GetxProductsPresenter(loadProducts: loadProducts);

    await sut.loaddata();

    verify(loadProducts.load()).called(1);
  });
}