import 'dart:convert';

import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/screens/home_screen.dart';
import 'package:digital_card/screens/login_screen.dart';
import 'package:digital_card/services/socket_service.dart';
import "package:shared_preferences/shared_preferences.dart";

import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:provider/provider.dart';

int employeeID = 0;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

final socketService = SocketService();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: loadLogin(),
          builder: (context, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snap.hasError) {
              return const Center(
                  child: Text("Ocurrio un error al cargar los datos"));
            }

            Map<String, dynamic> data = snap.data;
            if (data["isLogin"]) {
              employeeID = (data["employee"] as Employee).employeeID;
              return HomeScreen(employee: data["employee"]);
            }
            return const LoginScreen();
          }),
    );
  }

  Future<Map<String, dynamic>> loadLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool("isLogin") ?? false;
    String employeeDecode = prefs.getString("employee") ?? "";
    Employee? employee;
    if (employeeDecode.isNotEmpty) {
      employee = Employee.fromJson(json.decode(employeeDecode));
    }
    return {"isLogin": isLogin, "employee": employee};
  }
}
