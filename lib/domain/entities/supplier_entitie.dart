import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SupplierEntity extends Equatable {
  final int id;
  final String name;

  SupplierEntity({@required this.id, @required this.name});

  List get props => ['id', 'name'];
}
