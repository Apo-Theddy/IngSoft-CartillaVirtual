import 'package:digital_card/models/dish_model.dart';

class OrderItem {
  int orderItemID;
  int quantity;
  Dish dish;

  OrderItem(this.orderItemID, this.dish, this.quantity);

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final dish = Dish.fromJson(json["Dish"]);
    return OrderItem(json["OrderItemID"], dish, json["Quantity"]);
  }
}
