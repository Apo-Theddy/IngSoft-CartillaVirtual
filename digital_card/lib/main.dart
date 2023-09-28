import 'package:digital_card/screens/home_screen.dart';

import 'package:flutter/material.dart';
import "package:get/get.dart";

// final socket = SocketService();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
