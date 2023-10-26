import 'package:digital_card/cards/dish_card.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:flutter/material.dart';

class ListDishesComponent extends StatelessWidget {
  const ListDishesComponent(
      {super.key, required this.snapshot, required this.employee});
  final AsyncSnapshot snapshot;
  final Employee employee;

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
