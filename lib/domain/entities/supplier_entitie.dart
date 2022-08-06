import 'package:equatable/equatable.dart';

class SupplierEntity extends Equatable {
  final int id;
  final String name;

  SupplierEntity({required this.id, required this.name});

  List get props => ['id', 'name'];
}
