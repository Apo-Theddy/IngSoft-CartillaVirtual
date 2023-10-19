import "dart:io";
import 'package:digital_card/cards/dish_card.dart';
import 'package:digital_card/cards/dish_cardV2.dart';
import 'package:digital_card/components/categories_component.dart';
import 'package:digital_card/components/grid_dishes_component.dart';
import 'package:digital_card/main.dart';
import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/services/dish_service.dart';
import 'package:flutter/material.dart';

final dishService = DishService();

class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key, required this.employee});
  final Employee employee;

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  bool isSearch = false;
  List<Dish> dishesSearch = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    updateDishContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoriesComponent(searchByCategory: searchByCategory),
            const SizedBox(height: 20),
            const Text("Platillos",
                style: TextStyle(fontSize: 30, fontFamily: "Harlowsi")),
            const SizedBox(height: 10),
            // Buscador
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: Offset(0, 2))
                  ]),
              child: Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    onChanged: (value) {
                      String content = value.trim();

                      if (content.isNotEmpty) {
                        dishService.getDishesByName(content).then((dishes) {
                          setState(() {
                            isSearch = true;
                            dishesSearch = dishes;
                          });
                        });
                      } else {
                        setState(() {
                          isSearch = false;
                        });
                      }
                    },
                    controller: searchController,
                    style: const TextStyle(fontFamily: "Roboto-Regular"),
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Buscador"),
                  )),
                  const Icon(Icons.search)
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (isSearch)
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearch = false;
                      searchController.text = "";
                    });
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Remover busqueda"),
                        Icon(Icons.delete_forever)
                      ]),
                ),
              ),
            if (isSearch)
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: dishesSearch.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      final dish = dishesSearch[i];
                      return DishCardV2(dish: dish);
                    }),
              )
            else
              FutureBuilder(
                  future: dishService.getDishs(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridDishesComponent(snapshot: snapshot);
                  }),
          ],
        ),
      ),
    );
  }

  updateDishContent() {
    socketService.socket.on("UpdateDish", (data) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  searchByCategory(List<Dish> dishes) {
    setState(() {
      isSearch = true;
      dishesSearch = dishes;
    });
  }
}
