import 'package:digital_card_desktop/screens/dish_screen.dart';
import 'package:digital_card_desktop/screens/employee_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        NavigationRail(
            backgroundColor: const Color(0xff10101D),
            extended: isExtended,
            selectedIconTheme: const IconThemeData(color: Color(0xffFEB30C)),
            unselectedIconTheme: const IconThemeData(color: Color(0xffFEB30C)),
            useIndicator: true,
            indicatorColor: Colors.white12,
            unselectedLabelTextStyle: const TextStyle(color: Colors.white),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            leading: !isExtended
                ? extendedIcon()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text("Bienvenido",
                            style:
                                TextStyle(color: Colors.white, fontSize: 19)),
                        extendedIcon(),
                      ]),
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                  icon: Tooltip(message: "Home", child: Icon(Icons.home)),
                  label: Text("Home")),
              NavigationRailDestination(
                  icon: Tooltip(
                      message: "Platillos",
                      child: Icon(Icons.fastfood_outlined)),
                  label: Text("Platillos")),
              NavigationRailDestination(
                  icon: Tooltip(
                      message: "Mesas", child: Icon(Icons.table_bar_outlined)),
                  label: Text("Mesas")),
              NavigationRailDestination(
                  icon: Tooltip(
                      message: "Pedidos", child: Icon(Icons.shopify_rounded)),
                  label: Text("Pedidos")),
              NavigationRailDestination(
                  icon: Tooltip(
                      message: "Empleados", child: Icon(Icons.people_alt)),
                  label: Text("Empleados")),
            ],
            selectedIndex: _currentIndex),
        Expanded(child: _buildContentPage())
      ]),
    );
  }

  Widget _buildContentPage() {
    List pages = [
      DishScreen(),
      Container(color: Colors.blue),
      Container(color: Colors.green),
      Container(color: Colors.orange),
      EmployeeScreen()
    ];
    return pages[_currentIndex];
  }

  Widget extendedIcon() {
    return GestureDetector(
        onTap: () {
          setState(() {
            isExtended = !isExtended;
          });
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.menu, color: Color(0xffFEB30C))));
  }
}
