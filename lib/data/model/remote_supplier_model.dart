import 'package:meta/meta.dart';

import './../../domain/entities/entities.dart';

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
