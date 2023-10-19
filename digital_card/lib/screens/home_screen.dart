import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/screens/chat_screen.dart';
import 'package:digital_card/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:digital_card/screens/dishes_screen.dart';
import 'package:digital_card/screens/tables_screen.dart';
import "package:flutter_hooks/flutter_hooks.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:salomon_bottom_bar/salomon_bottom_bar.dart";

class HomeScreen extends StatefulHookWidget {
  const HomeScreen({super.key, required this.employee});
  final Employee employee;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final currentIndex = useState<int>(0);
    // final pageController = usePageController(initialPage: currentIndex.value);

    return Scaffold(
      backgroundColor: const Color(0XFFFFFEFE),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff183365),
                ),
                margin: const EdgeInsets.only(bottom: 10, top: 40),
                child: const Icon(Icons.person, color: Colors.white, size: 60)),
            Text(widget.employee.names,
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: const Text("Restaurante 1"),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildContent(),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.fastfood_rounded),
                title: const Text("Platillos")),
            SalomonBottomBarItem(
                icon: const Icon(Icons.table_bar), title: const Text("Mesas"))
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChatScreen(employee: widget.employee),
              transition: Transition.cupertino);
        },
        mini: true,
        backgroundColor: Colors.black38,
        child: const Icon(Icons.messenger_outlined),
      ),
    );
  }

  Widget _buildContent() {
    List displays = [
      DishesScreen(employee: widget.employee),
      const TablesScreen()
    ];
    return displays[currentIndex];
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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.off(const LoginScreen());
  }
}
