import 'package:digital_card/cards/dish_card.dart';
import 'package:digital_card/components/categories_component.dart';
import 'package:digital_card/main.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/screens/login_screen.dart';
import 'package:digital_card/services/dish_service.dart';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import "package:get/get.dart";

final dishService = DishService();

class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key, required this.employee});
  final Employee employee;

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  @override
  void initState() {
    updateDishContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: const Text("Restaurante 1"),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 22),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoriesComponent(),
            const SizedBox(height: 20),
            const Text("Dishes",
                style: TextStyle(fontSize: 30, fontFamily: "Harlowsi")),
            FutureBuilder(
                future: dishService.getDishs(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final dish = snapshot.data[index];
                            return DishCard(dish: dish);
                          }));
                }),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff183365),
                ),
                margin: const EdgeInsets.only(bottom: 10, top: 40),
                child: const Icon(Icons.person, color: Colors.white, size: 60)),
            Text("${widget.employee.names}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("DNI"),
                    informationWidget(widget.employee.dni,
                        Icons.camera_front_rounded, Colors.black),
                    const SizedBox(height: 20),
                    const Text("Fecha de contrato"),
                    informationWidget(widget.employee.creationDate,
                        Icons.calendar_month, Colors.black),
                    const SizedBox(height: 20),
                    const Text("Apellido Paterno"),
                    informationWidget(
                        widget.employee.lastname, Icons.man, Colors.black),
                    const SizedBox(height: 20),
                    const Text("Apellido Materno"),
                    informationWidget(widget.employee.motherLastname,
                        Icons.woman, Colors.black),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => logout(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: informationWidget(
                    "Cerrar Sesion", Icons.login, Colors.redAccent),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.off(const LoginScreen());
  }

  Widget informationWidget(String data, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 1)
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      padding: const EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(data), Icon(icon, color: iconColor)]),
    );
  }

  updateDishContent() {
    socketService.socket.on("UpdateDish", (data) {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
