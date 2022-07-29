import 'package:meta/meta.dart';
import 'package:get/get.dart';

import './../../domain/usecases/usecases.dart';
import './../../domain/helpers/helpers.dart';
import './../../ui/helpers/helpers.dart';
import './../../ui/pages/pages.dart';

class GetxProductsPresenter implements ProductsPresenter {
  final LoadProducts loadProducts;

  final _isLoading = true.obs;
  final _products = Rx<List<ProductViewModel>>();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<ProductViewModel>> get productsStream => _products.stream;

  GetxProductsPresenter({@required this.loadProducts});

  Future<void> loadData() async {
    try {
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
    } on DomainError {
      _products.addError(UIError.unexpected.description, StackTrace.empty);
    } finally {
      _isLoading.value = false;
    }
  }
}