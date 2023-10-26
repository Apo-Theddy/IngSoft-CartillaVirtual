import 'package:digital_card_desktop/cards/employee_card.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F6F8),
      body: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                Text("Empleados"),
                SizedBox(height: 20),
                Expanded(
                    child: ListView.builder(
                        itemCount: 40,
                        itemBuilder: (_, i) {
                          return EmployeeCard();
                        })),
              ]),
            ),
          ),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(children: [
                    Text(
                        "SELECCIONA UN EMPLEADO PARA DESPLEGAR SU INFORMACION"),
                  ])))
        ],
      ),
    );
  }
}
