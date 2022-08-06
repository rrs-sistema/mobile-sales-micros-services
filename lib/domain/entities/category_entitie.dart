import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String description;

  CategoryEntity({required this.id, required this.description});

  List get props => [id, description];
}
