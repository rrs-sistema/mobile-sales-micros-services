import 'package:meta/meta.dart';

import './../../domain/entities/entities.dart';
import './../../data/http/http.dart';

class RemoteProductModel {
  final String id;
  final String name;
  final String quantityAvailable;
  final String createdAt;
  final RemoteSupplierModel supplier;
  final RemoteCategoryModel category;

  RemoteProductModel(
      {@required this.id,
      @required this.name,
      @required this.quantityAvailable,
      @required this.createdAt,
      @required this.supplier,
      @required this.category});

  factory RemoteProductModel.fromJson(Map json) {
    if(!json.keys.toSet().containsAll(['id', 'name', 'quantity_available', 'created_at', 'supplier', 'category'])){
      throw HttpError.invalidData;
    }    
    return RemoteProductModel(
        id: json['id'].toString(),
        name: json['name'],
        quantityAvailable: json['quantity_available'].toString(),
        createdAt: json['created_at'],
        category: RemoteCategoryModel.fromJson(json['category']),
        supplier: RemoteSupplierModel.fromJson(json['supplier']));
  }

  ProductEntity toEntity() => ProductEntity(
      id: int.parse(id),
      name: name,
      quantityAvailable: int.parse(quantityAvailable),
      createdAt: DateTime.parse(createdAt),
      category: category.toEntity(),
      supplier: supplier.toEntity());
}

class RemoteCategoryModel {
  final String id;
  final String description;

  RemoteCategoryModel({@required this.id, @required this.description});

  factory RemoteCategoryModel.fromJson(Map json) {
    return RemoteCategoryModel(
        id: json['id'].toString(), description: json['description']);
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: int.parse(id),
        description: description,
      );
}

class RemoteSupplierModel {
  final String id;
  final String name;

  RemoteSupplierModel({@required this.id, @required this.name});

  factory RemoteSupplierModel.fromJson(Map json) {
    return RemoteSupplierModel(id: json['id'].toString(), name: json['name']);
  }

  SupplierEntity toEntity() => SupplierEntity(
        id: int.parse(id),
        name: name,
      );
}
