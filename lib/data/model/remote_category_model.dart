import 'package:meta/meta.dart';

import './../../domain/entities/entities.dart';

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
