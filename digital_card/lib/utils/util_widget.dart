import 'package:digital_card/models/dish_model.dart';
import 'package:flutter/material.dart';
import "package:digital_card/constants/contants_vars.dart";

Widget verifyImage(Size size, Dish dish) {
  Image image =
      Image.asset("assets/default-image.png", height: size.height * 0.12);
  if (dish.images!.isNotEmpty) {
    image = Image.network("$url/${dish.images![0].path}",
        height: size.height * 0.12);
  }
  return SizedBox(width: 150, child: image);
}
