import 'package:digital_card/cards/dish_order_card.dart';
import 'package:digital_card/models/order_model.dart';
import 'package:digital_card/services/order_service.dart';
import 'package:flutter/material.dart';

final orderService = OrderService();

class TableContentScreen extends StatelessWidget {
  const TableContentScreen({super.key, required this.tableID});
  final int tableID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
          future: orderService.getOrderByTable(tableID),
          builder: (_, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snap.hasError) {
              return const Center(
                  child: Text("Ocurrio un problema al obtener las ordenes"));
            } else if (snap.data == null) {
              return const Center(child: Text("Sin ordenes"));
            }
            final order = (snap.data as Order);

            final totalDishes = order.orderItems.length;
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total platillos: $totalDishes",
                      style: const TextStyle(
                          fontSize: 30, fontFamily: "Harlowsi")),
                  const SizedBox(height: 15),
                  Expanded(
                      child: ListView.builder(
                          itemCount: totalDishes,
                          itemBuilder: (_, i) {
                            return DishOrderCard(
                                orderItem: order.orderItems[i]);
                          }))
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff183365),
          onPressed: () {},
          mini: true,
          child: const Icon(Icons.add)),
    );
  }
}
