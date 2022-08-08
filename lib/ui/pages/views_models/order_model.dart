import './../../pages/categories/categories.dart';

class OrderModel {
  String id;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  List<CartItemViewModel> products;
  String status;
  String copyAndPaste;
  double total;

  OrderModel({
    required this.id,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.products,
    required this.status,
    required this.copyAndPaste,
    required this.total,
  });
}
