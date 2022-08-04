import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SupplierViewModel extends Equatable {
  final int id;
  final String name;

  SupplierViewModel({@required this.id, @required this.name});

  List get props => [id, name];
}
