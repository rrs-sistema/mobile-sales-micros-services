import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import './entities.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final int quantityAvailable;
  final double price;
  final String createdAt;
  final SupplierEntity supplier;
  final CategoryEntity category;

  ProductEntity(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.imgUrl,
      @required this.quantityAvailable,
      @required this.createdAt,
      @required this.price,
      @required this.supplier,
      @required this.category});

  List get props => [
        id,
        name,
        description,
        imgUrl,
        quantityAvailable,
        createdAt,
        price,
        supplier,
        category
      ];
}
