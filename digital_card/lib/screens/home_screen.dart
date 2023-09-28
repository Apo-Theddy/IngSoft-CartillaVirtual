import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/services/dish_service.dart';
import 'package:digital_card/services/tables_service.dart';
import 'package:flutter/material.dart';
import 'package:digital_card/screens/dishes_screen.dart';
import 'package:digital_card/screens/tables_screen.dart';
import "package:flutter_hooks/flutter_hooks.dart";
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

final screens = [const DishesScreen(), const TablesScreen()];

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tableService = TablesService();
    tableService.getTable(1).then((value) {});

    final currentIndex = useState<int>(0);
    final pageController = usePageController(initialPage: currentIndex.value);

    return Scaffold(
      backgroundColor: const Color(0XFFFFFEFE),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) => currentIndex.value = index,
        children: screens,
      ),
      bottomNavigationBar: BottomBarInspiredOutside(
        items: const [
          TabItem(
            icon: Icons.fastfood_outlined,
            title: 'Platillos',
          ),
          TabItem(
            icon: Icons.table_bar_outlined,
            title: 'Mesas',
          )
        ],
        backgroundColor: Colors.white,
        color: Colors.black,
        colorSelected: Colors.white,
        indexSelected: currentIndex.value,
        onTap: (int index) {
          currentIndex.value = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastEaseInToSlowEaseOut,
          );
        },
        top: -28,
        animated: true,
        itemStyle: ItemStyle.circle,
        curve: Curves.fastOutSlowIn,
        chipStyle: const ChipStyle(
            background: Color(0xff183365),
            notchSmoothness: NotchSmoothness.defaultEdge),
      ),
    );
  }
}
