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
      {required this.id,
      required this.name,
      required this.description,
      required this.imgUrl,
      required this.quantityAvailable,
      required this.createdAt,
      required this.price,
      required this.supplier,
      required this.category});

  factory LocalProductModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'id',
      'name',
      'description',
      'imgUrl',
      'quantityAvailable',
      'createdAt',
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
        imgUrl: json['imgUrl'],
        quantityAvailable: int.parse(json['quantityAvailable']),
        createdAt: json['createdAt'],
        price: double.parse(json['price']),
        category: LocalCategoryModel.fromJson(json['category']),
        supplier: LocalSupplierModel.fromJson(json['supplier']));
  }

  factory LocalProductModel.fromEntity(ProductEntity entity) => LocalProductModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    imgUrl: entity.imgUrl,
    quantityAvailable: entity.quantityAvailable,
    createdAt: entity.createdAt,
    price: entity.price,
    category: LocalCategoryModel(id: entity.category.id, description: entity.category.description,),
    supplier: LocalSupplierModel(id: entity.category.id, name: entity.supplier.name,),
  );
  

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

      Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'description': description,
        'imgUrl': imgUrl,
        'quantityAvailable': quantityAvailable.toString(),
        'createdAt': createdAt,
        'price': price.toString(),
        'category': {'id': category.id.toString(), 'description': category.description},
        'supplier': {'id': supplier.id.toString(), 'name': supplier.name},
      };

}
