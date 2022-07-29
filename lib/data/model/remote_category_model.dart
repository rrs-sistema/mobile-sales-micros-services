import 'package:meta/meta.dart';

import './../../domain/entities/entities.dart';
import './../../data/http/http.dart';

class RemoteCategoryModel {
  final String id;
  final String description;

  RemoteCategoryModel(
      {@required this.id,
      @required this.description,});

  factory RemoteCategoryModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'id',
      'description',
    ])) {
      throw HttpError.invalidData;
    }
    return RemoteCategoryModel(
        id: json['id'].toString(),
        description: json['description'],);
  }

  CategoryEntity toEntity() => CategoryEntity(
      id: int.parse(id),
      description: description,);
}