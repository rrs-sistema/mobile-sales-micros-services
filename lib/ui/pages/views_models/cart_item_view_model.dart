import 'views_models.dart';

class CartItemViewModel {
  late ProductViewModel item;
  late int quantity;

  CartItemViewModel( { required this.item, required this.quantity } );

  double totalPrice() => item.price * quantity;
}