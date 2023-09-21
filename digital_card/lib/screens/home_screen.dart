import 'package:flutter/material.dart';
import 'package:digital_card/screens/dishes_screen.dart';
import 'package:digital_card/screens/tables_screen.dart';
import "package:flutter_hooks/flutter_hooks.dart";

final screens = [DishesScreen(), TablesScreen()];

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);

    final pageController = usePageController(initialPage: currentIndex.value);

    return Scaffold(
      backgroundColor: const Color(0XFFFFFEFE),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) => currentIndex.value = index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) {
          currentIndex.value = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: "Platillos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_bar),
            label: "Mesas",
          ),
        ],
      ),
    );
  }
}
