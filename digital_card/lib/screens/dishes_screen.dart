import 'package:digital_card/cards/dish_card.dart';
import 'package:digital_card/components/categories_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DishesScreen extends StatelessWidget {
  const DishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Restaurante 1"),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 22),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CategoriesComponent(),
              const SizedBox(height: 20),
              const Text("Dishes",
                  style: TextStyle(fontSize: 30, fontFamily: "Harlowsi")),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // Ajusta la altura automáticamente
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return DishCard(id: index);
                  },
                ),
              )
            ],
          )),
    );
  }
}

class CartController extends GetxController {
  List<int> dishes = [];

  void addDish(int dish) {
    dishes.add(dish);
  }
}
