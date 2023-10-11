import 'package:digital_card/models/order_dish_model.dart';

class CreateOrderModel {
  int tableID;
  List<OrderDishModel> orderDishes = [];

  addOrderDish(OrderDishModel orderDish) {
    orderDishes.add(orderDish);
  }

  CreateOrderModel(this.tableID);

  Map<String, dynamic> toJson() {
    return {
      "TableID": tableID,
      "OrderDishes": orderDishes.map((orderDish) => orderDish.toJson()).toList()
    };
  }
}
