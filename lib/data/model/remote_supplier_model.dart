import 'package:meta/meta.dart';

import './../../domain/entities/entities.dart';
import './../../data/http/http.dart';

class RemoteSupplierModel {
  final String id;
  final String name;

  RemoteSupplierModel({@required this.id, @required this.name});

  factory RemoteSupplierModel.fromJson(Map json) {
   if (!json.keys.toSet().containsAll([
      'id',
      'name',
    ])) {
      throw HttpError.invalidData;
    }    
    return RemoteSupplierModel(id: json['id'].toString(), name: json['name']);
  }

  SupplierEntity toEntity() => SupplierEntity(
        id: int.parse(id),
        name: name,
      );
}
