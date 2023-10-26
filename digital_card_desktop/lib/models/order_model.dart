import 'package:digital_card_desktop/models/order_item_model.dart';
import 'package:digital_card_desktop/models/table_model.dart';

class Order {
  int orderID;
  String? orderDate;
  bool? isComplete;
  bool? isActive;
  TableModel table;
  List<OrderItem> orderItems;

  Order(this.orderID, this.orderDate, this.isComplete, this.isActive,
      this.table, this.orderItems);

  factory Order.fromJson(Map<String, dynamic> json) {
    final table = TableModel.fromJson(json["Table"]);
    final orderItems = (json["OrderItems"] as List)
        .map((orderItem) => OrderItem.fromJson(orderItem))
        .toList();

    return Order(json["OrderID"], json["OrderDate"], json["IsComplete"],
        json["IsActive"], table, orderItems);
  }
}
