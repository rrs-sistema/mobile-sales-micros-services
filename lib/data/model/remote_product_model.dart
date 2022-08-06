import './../../domain/entities/entities.dart';
import './../../data/http/http.dart';
import './../model/model.dart';

class RemoteProductModel {
  final String id;
  final String name;
  final String description;
  final String quantityAvailable;
  final String imgUrl;
  final String createdAt;
  final String price;
  final RemoteSupplierModel supplier;
  final RemoteCategoryModel category;

  RemoteProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.imgUrl,
      required this.quantityAvailable,
      required this.createdAt,
      required this.price,
      required this.supplier,
      required this.category});

  factory RemoteProductModel.fromJson(Map json) {
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
      throw HttpError.invalidData;
    }
    return RemoteProductModel(
        id: json['id'].toString(),
        name: json['name'],
        description: json['description'],
        imgUrl: json['img_url'],
        quantityAvailable: json['quantity_available'].toString(),
        createdAt: json['created_at'],
        price: json['price'].toString(),
        category: RemoteCategoryModel.fromJson(json['category']),
        supplier: RemoteSupplierModel.fromJson(json['supplier']));
  }

  ProductEntity toEntity() => ProductEntity(
      id: int.parse(id),
      name: name,
      description: description,
      imgUrl: imgUrl,
      quantityAvailable: int.parse(quantityAvailable),
      createdAt: createdAt,
      price: double.parse(price),
      category: category.toEntity(),
      supplier: supplier.toEntity());
}
