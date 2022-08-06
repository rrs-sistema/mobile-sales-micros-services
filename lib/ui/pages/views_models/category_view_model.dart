import 'package:equatable/equatable.dart';

class CategoryViewModel extends Equatable {
  final int id;
  final String description;

  CategoryViewModel({required this.id, required this.description});

  List get props => [id, description];
}
