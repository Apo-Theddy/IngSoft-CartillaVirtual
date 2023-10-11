import 'package:digital_card_desktop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: false,
      home: HomeScreen(),
    );
  }
}
