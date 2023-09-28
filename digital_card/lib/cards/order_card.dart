import 'package:digital_card/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 3,
                offset: Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.table.tableName),
          Row(
            children: [
              Text("Orden: "),
              Text(order.isComplete! ? "Completada" : "En progreso",
                  style: TextStyle(
                      color: order.isComplete!
                          ? Colors.green
                          : Colors.orangeAccent))
            ],
          )
        ],
      ),
    );
  }
}
