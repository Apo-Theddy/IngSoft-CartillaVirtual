import 'dart:convert';
import 'dart:ffi';

import 'package:digital_card_desktop/components/dish_content_component.dart';
import 'package:digital_card_desktop/main.dart';
import 'package:digital_card_desktop/models/dish_model.dart';
import 'package:digital_card_desktop/screens/dish_add_screen.dart';
import 'package:digital_card_desktop/services/dish_service.dart';
import 'package:digital_card_desktop/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:digital_card_desktop/cards/dish_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:get/get.dart";

final dishService = DishService();

class DishScreen extends StatefulHookWidget {
  const DishScreen({Key? key}) : super(key: key);

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  final scrollController = ScrollController();
  Dish? currentDish;
  bool isSelected = false;
  Key _dishContentKey = UniqueKey();
  List<Dish> dishes = [];

  @override
  void initState() {
    super.initState();
    updateNewDish();
    loadDishes();
  }
  // Key para DishContentComponent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Text(
                "Platillos",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        style: GoogleFonts.roboto(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Buscador",
                        ),
                      ),
                    ),
                    const Icon(Icons.search)
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                    controller: scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isSelected ? 3 : 5,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: dishes.length,
                    itemBuilder: (_, i) {
                      final dish = dishes[i];
                      return GestureDetector(
                        onTap: () {
                          currentDish = dish;
                          setState(() {
                            isSelected = true;
                            _dishContentKey = UniqueKey();
                          });
                        },
                        child: DishCard(dish: dish),
                      );
                    }),
              ),
            ],
          )),
          if (isSelected)
            DishContentComponent(
                key: _dishContentKey,
                dish: currentDish!,
                closeDishInformation: closeDishInformation,
                removeDishOfList: removeDishOfList,
                updateListDish: updateListDish)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return const AlertDialog(
                    title: Center(child: Text("Agregar platillo")),
                    content: DishAddPage());
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  loadDishes() {
    dishService.getDishs().then((value) {
      setState(() {
        dishes = value;
      });
    });
  }

  removeDishOfList(int dishID) {
    int index = dishes.indexWhere((dish) => dish.dishID == dishID);
    setState(() {
      dishes.removeAt(index);
    });
  }

  updateNewDish() {
    socket.on("UpdateDish", (data) {
      if (mounted) {
        setState(() {
          data["Images"] = [];
          Dish dish = Dish.fromJson(data);
          dishes.add(dish);
        });
        if (dishes.length > 10) scrollToLast();
      }
    });
  }

  updateListDish(int dishID, Dish? newDish) {
    int index = dishes.indexWhere((dish) => dish.dishID == dishID);
    setState(() {
      print(index);
      if (newDish != null) {
        dishes.insert(index, newDish);
      }
    });
  }

  closeDishInformation() {
    setState(() {
      isSelected = false;
    });
  }

  scrollToLast() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 500);
  }
}
