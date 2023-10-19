import 'package:digital_card/models/category_model.dart';
import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/screens/dishes_screen.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.category, required this.searchByCategory});
  final Category category;
  final Function(List<Dish> dishes) searchByCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dishService.getDishsByCategory(category.categoryName).then((dishes) {
          if (dishes.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "No se encontraron platillos con la categoria ${category.categoryName}"),
              duration: const Duration(seconds: 1),
            ));
            return;
          }
          searchByCategory(dishes);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
            ]),
        child: Column(
          children: [
            const Icon(Icons.food_bank, size: 55),
            Text(
              category.categoryName,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
