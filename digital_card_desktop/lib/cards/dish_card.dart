import 'package:digital_card_desktop/constants/contants_vars.dart';
import 'package:digital_card_desktop/models/dish_model.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class DishCard extends StatelessWidget {
  const DishCard({super.key, required this.dish});
  final Dish dish;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: size.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage("assets/background-dish.jpg"),
                          fit: BoxFit.cover)),
                ),
                if (dish.categories != null && dish.categories!.isNotEmpty)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        dish.categories![0].categoryName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                Center(
                    child: Column(
                  children: [
                    verifyImage(size, dish),
                  ],
                )),
              ],
            ),
            SizedBox(height: 10),
            Text(
              dish.dishName,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              "Precio platillo: ${dish.unitPrice}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ));
  }

  Widget verifyImage(Size size, Dish dish) {
    Widget image =
        Image.asset("assets/default-image.png", height: size.height * 0.2);
    if (dish.images!.isNotEmpty) {
      image = Image.network(
        "$url/${dish.images![0].path}",
        height: size.height * 0.2,
      );
    }
    return Container(
        padding: const EdgeInsets.all(5),
        width: size.width * 0.15,
        child: image);
  }
}
