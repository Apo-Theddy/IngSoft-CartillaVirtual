import 'package:digital_card/cards/category_card.dart';
import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/services/categories_service.dart';
import 'package:flutter/material.dart';

final categoriesService = CategoriesService();

class CategoriesComponent extends StatelessWidget {
  const CategoriesComponent({super.key, required this.searchByCategory});
  final Function(List<Dish> dishes) searchByCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categorias",
            style: TextStyle(fontSize: 30, fontFamily: "Harlowsi")),
        FutureBuilder(
          future: categoriesService.getCategories(),
          builder: (ctx, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snap.hasError) {
              return const Center(
                  child: Text("Ocurrio un problema al obtener las categorias"));
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snap.data.map<Widget>((category) {
                  return CategoryCard(
                      category: category, searchByCategory: searchByCategory);
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
