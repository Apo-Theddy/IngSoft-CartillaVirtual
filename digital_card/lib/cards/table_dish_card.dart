import 'package:digital_card/models/table_model.dart';
import 'package:flutter/material.dart';

class CardTableDish extends StatelessWidget {
  const CardTableDish({super.key, required this.table});
  final TableModel table;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
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
      height: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const Icon(Icons.table_bar_sharp), Text(table.tableName)],
      ),
    );
  }
}
