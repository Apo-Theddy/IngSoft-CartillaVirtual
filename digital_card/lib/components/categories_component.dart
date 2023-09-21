import 'package:digital_card/cards/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesComponent extends StatelessWidget {
  const CategoriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Categories",
            style: TextStyle(fontSize: 30, fontFamily: "Harlowsi")),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Desplazamiento horizontal
          child: Row(
            children: List.generate(8, (i) => CategoryCard()),
          ),
        ),
      ],
    );
  }
}
