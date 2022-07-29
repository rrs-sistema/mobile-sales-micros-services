import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ProductViewModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final int quantityAvailable;
  final double price;
  final String createdAt;
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

  List get props => ['id', 'name', 'description', 'imgUrl', 'quantityAvailable', 'createdAt', 'price', 'supplier', 'category'];
}

class CategoryViewModel extends Equatable {
  final int id;
  final String description;

  CategoryViewModel({this.id, this.description});

  List get props => ['id', 'description'];
}

class SupplierViewModel extends Equatable {
  final int id;
  final String name;

  SupplierViewModel({this.id, this.name});

  List get props => ['id', 'name'];
}
