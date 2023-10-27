import 'package:digital_card/main.dart';
import 'package:digital_card/models/create_order_model.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/models/order_dish_model.dart';
import 'package:digital_card/models/table_model.dart';
import 'package:digital_card/screens/dish_content_screen.dart';
import 'package:digital_card/screens/table_content_screen.dart';
import 'package:flutter/material.dart';

class CardTableDish extends StatelessWidget {
  const CardTableDish(
      {super.key,
      required this.table,
      required this.orderDish,
      required this.updateCountDish});
  final TableModel table;
  final OrderDishModel orderDish;
  final VoidCallback updateCountDish;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final createOrderModel = CreateOrderModel(table.tableID);
        createOrderModel.addOrderDish(orderDish);
        orderService.addOrder(createOrderModel);
        updateCountDish();
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: Offset(0, 2))
            ]),
        height: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Icon(Icons.table_bar_sharp), Text(table.tableName)],
        ),
      ),
    );
  }
}
