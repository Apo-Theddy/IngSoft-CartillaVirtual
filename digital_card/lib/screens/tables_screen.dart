import 'package:digital_card/cards/table_card.dart';
import 'package:digital_card/screens/table_content_screen.dart';
import 'package:digital_card/services/tables_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:digital_card/cards/order_card.dart";

final tableService = TablesService();

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 223, 164, 164),
          elevation: 0,
          actions: [
            FutureBuilder(
                future: orderService.getOrders(),
                builder: (_, AsyncSnapshot snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snap.hasError) {
                    return const Center(
                        child:
                            Text("Ocurrio un problema al obtener las ordenes"));
                  }

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: const Color(0XFFFFFEFE),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          context: context,
                          builder: (_) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                      "Ordenes: ${snap.data.length}",
                                      style: const TextStyle(
                                          fontFamily: "Harlowsi", fontSize: 25),
                                    )),
                                Expanded(
                                    child: ListView.builder(
                                        itemCount: snap.data.length,
                                        itemBuilder: (_, i) {
                                          final order = snap.data[i];
                                          return OrderCard(order: order);
                                        }))
                              ],
                            );
                          });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xff28DD8A),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(children: [
                        const Icon(Icons.shopping_cart),
                        const SizedBox(width: 5),
                        Text("${snap.data.length}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  );
                })
          ]),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: tableService.getTables(),
                  builder: (_, AsyncSnapshot snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snap.hasError) {
                      return const Center(
                          child: Text("No se pudo cargar las mesas"));
                    }
                    return GridView.builder(
                        itemCount: snap.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (_, i) {
                          final table = snap.data[i];
                          return TableCard(table: table);
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
