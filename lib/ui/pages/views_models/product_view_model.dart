import 'package:equatable/equatable.dart';

import './views_models.dart';

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

  ProductViewModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.imgUrl,
      required this.quantityAvailable,
      required this.createdAt,
      required this.price,
      required this.supplier,
      required this.category});

  List get props => [
        id,
        name,
        description,
        imgUrl,
        quantityAvailable,
        createdAt,
        price,
        supplier,
        
      ];
}
