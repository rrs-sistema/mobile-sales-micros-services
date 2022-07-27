import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final int quantityAvailable;
  final DateTime createdAt;
  final SupplierEntity supplier;
  final CategoryEntity category;

  ProductEntity(
      {@required this.id,
      @required this.name,
      @required this.quantityAvailable,
      @required this.createdAt,
      @required this.supplier,
      @required this.category});

  List get props => ['id', 'name', 'quantityAvailable', 'createdAt', 'supplier', 'category'];
}

class CategoryEntity extends Equatable {
  final int id;
  final String description;

  CategoryEntity({this.id, this.description});

  List get props => ['id', 'description'];
}

class SupplierEntity extends Equatable {
  final int id;
  final String name;

  SupplierEntity({this.id, this.name});

  List get props => ['id', 'name'];
}
