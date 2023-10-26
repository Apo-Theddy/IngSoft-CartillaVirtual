import 'package:digital_card_desktop/cards/category_card.dart';
import 'package:digital_card_desktop/models/category_model.dart';
import 'package:digital_card_desktop/screens/dish_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoriesComponent extends StatefulHookWidget {
  const CategoriesComponent(
      {super.key, required this.categories, required this.dishID});
  final int dishID;
  final List<Category> categories;

  @override
  State<CategoriesComponent> createState() => _CategoriesComponentState();
}

class _CategoriesComponentState extends State<CategoriesComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: widget.categories
                  .map((category) => CategoryCard(
                      category: category, removeCategory: removeCategory))
                  .toList())),
    );
  }

  void removeCategory(int categoryID) async {
    categoryService.removeCategoryOfDish(widget.dishID, categoryID).then((_) {
      setState(() {
        widget.categories
            .removeWhere((category) => category.categoryID == categoryID);
      });
    });
  }
}
