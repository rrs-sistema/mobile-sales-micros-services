import './../../domain/entities/entities.dart';

class LocalCategoryModel {
  final int id;
  final String description;

  LocalCategoryModel({
    required this.id,
    required this.description,
  });

  factory LocalCategoryModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll([
      'id',
      'description',
    ])) {
      throw Exception();
    }
    return LocalCategoryModel(
      id: int.parse(json['id']),
      description: json['description'],
    );
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        description: description,
      );

  factory LocalCategoryModel.fromEntity(CategoryEntity entity) =>
      LocalCategoryModel(
        id: entity.id,
        description: entity.description,
      );

  Map<String, String> toJson() =>
      {'id': id.toString(), 'description': description};
}
