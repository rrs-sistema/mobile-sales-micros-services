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
  LoadProductSpy loadProducts;
  GetxProductsPresenter sut;

  setUp(() {
    loadProducts = LoadProductSpy();
    sut = GetxProductsPresenter(loadProducts: loadProducts);
  });
  
  test('Shoul call LoadProdiucts on loadData', () async {
    await sut.loaddata();

    verify(loadProducts.load()).called(1);
  });
}