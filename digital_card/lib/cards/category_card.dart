import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Category");
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
        child: const Column(
          children: [
            Icon(Icons.food_bank, size: 55),
            Text(
              "Bebidas Heladas",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
