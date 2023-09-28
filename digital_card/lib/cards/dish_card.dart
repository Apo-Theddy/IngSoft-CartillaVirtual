import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/screens/dish_content_screen.dart';
import 'package:digital_card/utils/util_widget.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class DishCard extends StatelessWidget {
  const DishCard({super.key, required this.dish});
  final Dish dish;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Get.to(() => DishContentScreen(dish: dish),
            transition: Transition.cupertino);
      },
      child: Stack(
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
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5)),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dish.dishName,
                    style: const TextStyle(
                        fontSize: 20, fontFamily: "PlayFairDisplay")),
                Text("Precio: S/${dish.unitPrice}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PlayFairDisplay")),
              ],
            ),
          ),
          Container(
              height: size.height * 0.15,
              alignment: Alignment.centerRight,
              child: verifyImage(size, dish)),
        ],
      ),
    );
  }
}
