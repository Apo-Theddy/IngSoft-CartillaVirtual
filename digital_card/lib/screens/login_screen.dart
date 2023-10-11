import 'dart:convert';

import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/screens/home_screen.dart';
import 'package:digital_card/services/employee_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

final employeeService = EmployeeService();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final dniController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEFEFF),
      body: Column(children: [
        Expanded(
            child: Stack(
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/hello-vector.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200),
                        bottomLeft: Radius.circular(200)))),
            const Align(
                alignment: Alignment.center,
                child: Text("Bienvenido",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: "LilitaOne",
                        fontWeight: FontWeight.bold))),
          ],
        )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Flexible(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: dniController,
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  decoration: const InputDecoration(
                      hintText: "DNI",
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.perm_identity)),
                ),
              )),
              const SizedBox(height: 30),
              CupertinoButton(
                  color: const Color(0xff183365),
                  child: const Text("Acceder"),
                  onPressed: () {
                    if (dniController.text.isNotEmpty &&
                        dniController.text.length == 8) {
                      employeeService
                          .getEmployee(dniController.text)
                          .then((employee) {
                        if (employee != null) {
                          setLogin(employee);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => HomeScreen(
                                      employee:
                                          employee) // Reemplazar 'HomeScreen' con tu pantalla principal
                                  ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "El empleado con el DNI ingreado no existe"),
                                  duration: Duration(seconds: 1)));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Ingrese un DNI correcto"),
                          duration: Duration(seconds: 1)));
                    }
                  })
            ],
          ),
        )),
      ]),
    );
  }

  Future<void> setLogin(Employee employee) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", true);
    await prefs.setString("employee", json.encode(employee.toJson()));
  }
}
