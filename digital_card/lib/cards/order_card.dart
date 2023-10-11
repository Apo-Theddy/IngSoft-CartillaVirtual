import 'package:digital_card/models/order_model.dart';
import 'package:digital_card/screens/table_content_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:flutter_hooks/flutter_hooks.dart";

class OrderCard extends HookWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    final isComplete = useState<bool>(order.isComplete!);

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
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                isComplete.value = !isComplete.value;
                orderService.setOrderComplete(order.orderID);
              },
              label: isComplete.value ? "Sin Completar" : "Completar",
              borderRadius: BorderRadius.circular(10),
              backgroundColor:
                  isComplete.value ? Colors.redAccent : Colors.greenAccent,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.table.tableName),
            Row(
              children: [
                Text("Orden: "),
                Text(isComplete.value ? "Completada" : "En progreso",
                    style: TextStyle(
                        color: isComplete.value
                            ? Colors.green
                            : Colors.orangeAccent))
              ],
            )
          ],
        ),
      ),
    );
  }
}
