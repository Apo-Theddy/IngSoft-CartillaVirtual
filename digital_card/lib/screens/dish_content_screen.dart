import "dart:async";
import "dart:convert";

import 'package:digital_card/cards/table_dish_card.dart';
import "package:digital_card/models/dish_model.dart";
import "package:digital_card/models/order_dish_model.dart";
import "package:digital_card/services/tables_service.dart";
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:digital_card/constants/contants_vars.dart";

final tablesService = TablesService();

class DishContentScreen extends StatefulWidget {
  DishContentScreen({super.key, required this.dish});
  Dish dish;

  @override
  State<DishContentScreen> createState() => _DishContentScreenState();
}

class _DishContentScreenState extends State<DishContentScreen> {
  int countDish = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final totalPrice =
        countDish * widget.dish.unitPrice; // Calcula el precio sin formato
    final formatPrice = NumberFormat("#,##0.00", 'es').format(totalPrice);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Imagen
            Container(
                alignment: Alignment.center,
                height: 300,
                child: verifyImage(size)),
            // Dish information
            Text(widget.dish.dishName,
                style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff183365))),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // num dishes
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(100)),
                    child: validateDishQuantity()),
                Text(
                  "S/ $formatPrice",
                  style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff183365)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                if (widget.dish.quantityAvailable != null) {
                  if (widget.dish.quantityAvailable == 0) {
                    return;
                  }
                }
                showModalBottomSheet(
                    backgroundColor: const Color(0XFFFFFEFE),
                    context: context,
                    builder: (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                child: const Text("Mesas",
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: "Harlowsi"))),
                            SizedBox(
                              height: 100,
                              child: FutureBuilder(
                                  future: tablesService.getTables(),
                                  builder: (_, AsyncSnapshot snap) {
                                    if (snap.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snap.hasError) {
                                      return const Center(
                                          child: Text(
                                              "Ocurrio un error al obtener las mesas"));
                                    }
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snap.data.length,
                                      itemBuilder: (_, i) {
                                        final table = snap.data[i];
                                        final orderDish = OrderDishModel(
                                            widget.dish.dishName,
                                            widget.dish.dishID,
                                            countDish);
                                        return CardTableDish(
                                            table: table,
                                            orderDish: orderDish,
                                            updateCountDish: updateCountDish);
                                      },
                                    );
                                  }),
                            )
                          ],
                        ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Add to card",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Color(0xff183365)),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text("Description",
                style: TextStyle(
                    color: Color(0xff183365),
                    fontSize: 19,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
                widget.dish.description != null ? widget.dish.description! : "",
                style: const TextStyle(fontSize: 17))
          ]),
        ),
      ),
    );
  }

  Widget verifyImage(Size size) {
    Widget wig =
        Image.asset("assets/default-image.png", height: size.height * 0.16);
    if (widget.dish.images!.isNotEmpty) {
      wig = CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.8,
            initialPage: 0,
            enlargeCenterPage: true,
            enlargeFactor: 1,
            aspectRatio: 16 / 9,
            height: 250),
        items: widget.dish.images!
            .map((e) =>
                Image.network("$url/${e.path}", height: size.height * 0.16))
            .toList(),
      );
    }
    return wig;
  }

  Widget validateDishQuantity() {
    if (widget.dish.quantityAvailable! <= 0) {
      return const Text(
        "Sin disponibilidad",
        textAlign: TextAlign.center,
      );
    }
    return Row(children: [
      Expanded(
          child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black12),
                  elevation: MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                    ),
                  )),
              onPressed: () => {if (countDish > 1) setState(() => countDish--)},
              child: const SizedBox(
                height: 50,
                child: Icon(Icons.remove, color: Color(0xff183365)),
              ))),
      Expanded(
          child: Text(
        "$countDish",
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xff183365)),
      )),
      Expanded(
          child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black12),
                  elevation: MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                  )),
              onPressed: () {
                if (countDish < widget.dish.quantityAvailable!) {
                  setState(() {
                    countDish++;
                  });
                }
              },
              child: const SizedBox(
                height: 50,
                child: Icon(
                  Icons.add,
                  color: Color(0xff183365),
                ),
              ))),
    ]);
  }

  updateCountDish() {
    setState(() {
      if (countDish > widget.dish.quantityAvailable!) {
        countDish = countDish - widget.dish.quantityAvailable!;
      } else {
        countDish = widget.dish.quantityAvailable! - countDish;
      }
      widget.dish.quantityAvailable = countDish;
      countDish = 1;
    });
  }
}
