import 'package:meta/meta.dart';

import './../../domain/entities/entities.dart';
import './../model/model.dart';

class LocalProductModel {
  final int id;
  final String name;
  final String description;
  final String imgUrl;
  final int quantityAvailable;
  final double price;
  final String createdAt;
  final LocalSupplierModel supplier;
  final LocalCategoryModel category;

  LocalProductModel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.imgUrl,
      @required this.quantityAvailable,
      @required this.createdAt,
      @required this.price,
      @required this.supplier,
      @required this.category});

  factory LocalProductModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'id',
      'name',
      'description',
      'img_url',
      'quantity_available',
      'created_at',
      'price',
      'supplier',
      'category'
    ])) {
      throw Exception();
    }
    
    return LocalProductModel(
        id: int.parse(json['id']),
        name: json['name'],
        description: json['description'],
        imgUrl: json['img_url'],
        quantityAvailable: int.parse(json['quantity_available']),
        createdAt: json['created_at'],
        price: double.parse(json['price']),
        category: LocalCategoryModel.fromJson(json['category']),
        supplier: LocalSupplierModel.fromJson(json['supplier']));
  }

  ProductEntity toEntity() => ProductEntity(
      id: id,
      name: name,
      description: description,
      imgUrl: imgUrl,
      quantityAvailable: quantityAvailable,
      createdAt: createdAt,
      price: price,
      category: category.toEntity(),
      supplier: supplier.toEntity());
}
