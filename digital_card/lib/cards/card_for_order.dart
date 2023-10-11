import 'package:digital_card/models/create_order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardForOrder extends StatelessWidget {
  const CardForOrder({super.key, required this.createOrder});
  final CreateOrderModel createOrder;

  @override
  Widget build(BuildContext context) {
    const cardTextStyle =
        TextStyle(fontFamily: "PlayFairDisplay", fontSize: 20);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(0, 2)),
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Mesa: ${createOrder.tableID}", style: cardTextStyle),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Platos a pedir", style: cardTextStyle),
            Text("Cantidades", style: cardTextStyle),
          ],
        ),
        const SizedBox(height: 10),
        Column(
            children: createOrder.orderDishes
                .map((orderDish) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderDish.dishName,
                            style: const TextStyle(fontSize: 18)),
                        Text("${orderDish.quantity}",
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ))
                .toList()),
        Container(
          alignment: Alignment.center,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text("Ordernar"),
              onPressed: () {}),
        )
      ]),
    );
  }
}
