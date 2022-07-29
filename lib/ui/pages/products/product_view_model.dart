import 'package:meta/meta.dart';

class ProductViewModel {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final int quantityAvailable;
  final double price;
  final DateTime createdAt;
  final SupplierViewModel supplier;
  final CategoryViewModel category;

  ProductViewModel({
      @required this.id,
      @required this.name,
      @required this.description,
      @required this.imgUrl,
      @required this.quantityAvailable,
      @required this.createdAt,
      @required this.price,
      @required this.supplier,
      @required this.category});

}

class CategoryViewModel {
  final int id;
  final String description;

  CategoryViewModel({this.id, this.description});
}

class SupplierViewModel {
  final int id;
  final String name;

  SupplierViewModel({this.id, this.name});
}
