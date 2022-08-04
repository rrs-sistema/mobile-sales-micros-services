import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CategoryViewModel extends Equatable {
  final int id;
  final String description;

  CategoryViewModel({@required this.id, @required this.description});

  List get props => [id, description];
}
