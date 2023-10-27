import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/screens/dish_conent_screenv2.dart';
import 'package:digital_card/utils/util_widget.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class DishCardV2 extends StatelessWidget {
  const DishCardV2({super.key, required this.dish});
  final Dish dish;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(() => DishContentScreenV2(dish: dish),
            transition: Transition.cupertino);
      },
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verifyImage(size, dish),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(dish.dishName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Roboto-Regular",
                        fontSize: size.height * 0.019)),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "S/",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat-Bold"),
                  ),
                  Text(
                    "${dish.unitPrice}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat-Bold"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
