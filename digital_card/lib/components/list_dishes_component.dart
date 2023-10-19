import 'package:digital_card/cards/dish_card.dart';
import 'package:flutter/material.dart';

class ListDishesComponent extends StatelessWidget {
  const ListDishesComponent({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final dish = snapshot.data[index];
              return DishCard(dish: dish);
            }));
  }
}
