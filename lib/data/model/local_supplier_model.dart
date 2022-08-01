import 'package:meta/meta.dart';

import './../../domain/entities/entities.dart';
//import './../../data/http/http.dart';

class LocalSupplierModel {
  final int id;
  final String name;

  LocalSupplierModel({@required this.id, @required this.name});

  factory LocalSupplierModel.fromJson(Map json) {
    // if (!json.keys.toSet().containsAll([
    //   'id',
    //   'name',
    // ])) {
    //   throw HttpError.invalidData;
    // }    
    return LocalSupplierModel(id: int.parse(json['id']), name: json['name']);
  }

  SupplierEntity toEntity() => SupplierEntity(
        id: id,
        name: name,
      );
}
