import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/models/order_item_model.dart';
import 'package:digital_card/screens/dish_content_screen.dart';
import 'package:digital_card/utils/util_widget.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class DishOrderCard extends StatelessWidget {
  const DishOrderCard({super.key, required this.orderItem});
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: size.width - 80,
          height: size.height * 0.15,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5)),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(orderItem.dish.dishName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "PlayFairDisplay",
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Text("Cantidades pedidas: ${orderItem.quantity}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "PlayFairDisplay",
                  )),
              Text("Precio: S/${orderItem.dish.unitPrice}",
                  style: const TextStyle(
                      fontSize: 18, fontFamily: "PlayFairDisplay")),
            ],
          ),
        ),
        Container(
            height: size.height * 0.15,
            alignment: Alignment.centerRight,
            child: verifyImage(size, orderItem.dish)),
      ],
    );
  }
}
