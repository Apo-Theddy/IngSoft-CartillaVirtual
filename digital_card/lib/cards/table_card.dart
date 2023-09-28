import 'package:digital_card/models/table_model.dart';
import 'package:digital_card/screens/table_content_screen.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class TableCard extends StatelessWidget {
  const TableCard({super.key, required this.table});
  final TableModel table;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TableContentScreen(tableID: table.tableID),
            transition: Transition.cupertino);
      },
      child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 2))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/table-img.jpg", height: 100),
              Text(table.tableName)
            ],
          )),
    );
  }
}
