import 'package:digital_card/cards/dish_card.dart';
import 'package:digital_card/components/categories_component.dart';
import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/services/dish_service.dart';
import 'package:flutter/material.dart';
import "package:flutter_hooks/flutter_hooks.dart";

final dishService = DishService();

class DishesScreen extends HookWidget {
  const DishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: FutureBuilder(
                    future: dishService.getDishs(),
                    builder: (ctx, AsyncSnapshot snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snap.hasError) {
                        return const Center(
                            child: Text(
                                "Ocurrio un error al obtener los platillo"));
                      }
                      return ListView.builder(
                        shrinkWrap: true, // Ajusta la altura automáticamente
                        itemCount: snap.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dish = snap.data[index];
                          return DishCard(dish: dish);
                        },
                      );
                    }),
              )
            ],
          )),
    );
  }
}
