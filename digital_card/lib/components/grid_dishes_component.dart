import 'package:digital_card/cards/dish_cardV2.dart';
import 'package:digital_card/models/dish_model.dart';
import 'package:flutter/material.dart';

class GridDishesComponent extends StatelessWidget {
  const GridDishesComponent({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: snapshot.data.length,
          shrinkWrap: true,
          itemBuilder: (_, i) {
            final dish = snapshot.data[i];
            return DishCardV2(dish: dish);
          }),
    );
  }
}
