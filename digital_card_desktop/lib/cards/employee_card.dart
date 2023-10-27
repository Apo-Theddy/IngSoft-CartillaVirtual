import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 50,
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: Text("J"),
        ),
        SizedBox(width: 10),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Juan Jesus", style: TextStyle(fontWeight: FontWeight.bold))
        ]),
      ]),
    );
  }
}
