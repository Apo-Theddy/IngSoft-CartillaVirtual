import 'package:digital_card/cards/table_card.dart';
import 'package:flutter/material.dart';
import "package:digital_card/cards/order_card.dart";

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 223, 164, 164),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: const Color(0XFFFFFEFE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (_) {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (_, i) {
                            return OrderCard();
                          });
                    });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff28DD8A),
                    borderRadius: BorderRadius.circular(50)),
                child: const Row(children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 5),
                  Text("1", style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
              ),
            )
          ]),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (_, i) {
                    return TableCard();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
