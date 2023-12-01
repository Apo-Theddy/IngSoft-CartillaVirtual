import 'package:digital_card/cards/table_dish_card.dart';
import 'package:digital_card/constants/contants_vars.dart';
import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/models/order_dish_model.dart';
import 'package:digital_card/screens/dish_content_screen.dart';
import "package:flutter/gestures.dart";
import 'package:flutter/material.dart';
import "package:get/get.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:intl/intl.dart";
import 'package:slidable_button/slidable_button.dart';

class DishContentScreenV2 extends StatefulWidget {
  const DishContentScreenV2({super.key, required this.dish});
  final Dish dish;

  @override
  State<DishContentScreenV2> createState() => _DishContentScreenV2State();
}

class _DishContentScreenV2State extends State<DishContentScreenV2> {
  int countDish = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final totalPrice =
        countDish * widget.dish.unitPrice; // Calcula el precio sin formato
    final formatPrice = NumberFormat("#,##0.00", 'es').format(totalPrice);

    return Scaffold(
        backgroundColor: const Color(0xffF6EBDB),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 140,
                        child: SingleChildScrollView(
                          child: Text(
                            widget.dish.dishName,
                            style: const TextStyle(
                                fontSize: 28,
                                fontFamily: "MartianMono-VariableFont_wdth600"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.keyboard_return,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: verifyImage(size)),
                      SizedBox(
                          height: widget.dish.images!.isNotEmpty
                              ? size.height * .05
                              : 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCustomButton(Icons.add),
                          _buildQuantityAndPrice(formatPrice),
                          _buildCustomButton(Icons.remove),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: (widget.dish.description != null &&
                                widget.dish.description!.trim().length > 2)
                            ? size.height * 0.17
                            : null,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6,
                                spreadRadius: 3),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            widget.dish.description != null
                                ? widget.dish.description!.trim()
                                : "Sin Descripcion",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            margin: const EdgeInsets.all(15),
            child: _buildAddToCartButton(size)));
  }

  Widget _buildCustomButton(IconData icon) {
    return GestureDetector(
      onTap: () {
        if (icon == Icons.add) {
          if (countDish < widget.dish.quantityAvailable!) {
            setState(() => countDish++);
          }
        } else {
          if (countDish > 1) setState(() => countDish--);
        }
      },
      child: CustomPaint(
        painter: icon == Icons.add ? LeftPainterButton() : RightPaintButton(),
        child: Container(
          alignment: Alignment.topCenter,
          width: 45,
          height: 40,
          child: Icon(
            icon,
            size: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
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

  Widget _buildQuantityAndPrice(String unitPrice) {
    return Column(
      children: [
        Text(
          widget.dish.quantityAvailable! <= 0
              ? "Sin Disponibilidad"
              : "$countDish",
          style: TextStyle(
              fontSize: widget.dish.quantityAvailable! <= 0 ? 20 : 30,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "S/ $unitPrice",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(Size size) {
    return Container(
      padding: const EdgeInsets.all(3),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white60,
        gradient: const LinearGradient(
          colors: [Colors.white, Colors.white54],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: HorizontalSlidableButton(
        onChanged: (position) {
          if (position == SlidableButtonPosition.end &&
              widget.dish.quantityAvailable! > 0) {
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
          }
        },
        buttonWidth: 100,
        width: 220,
        isRestart: true,
        height: 70,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xffF8B0E1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.shopping_cart_checkout,
              color: Colors.white,
            )),
        child: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text("Add To Table",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget verifyImage(Size size) {
    Widget wig = Image.asset(
      "assets/default-image.png",
      height: size.height * 0.3,
    );
    if (widget.dish.images!.isNotEmpty) {
      wig = CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.9,
            initialPage: 0,
            enlargeCenterPage: true,
            enlargeFactor: 1,
            height: 250,
            aspectRatio: 16 / 9),
        items: widget.dish.images!
            .map((e) => Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background-dish.jpg"))),
                child: Image.network("$url/${e.path}",
                    height: size.height * 0.16)))
            .toList(),
      );
    }
    return wig;
  }
}

class LeftPainterButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white54
      ..shader = const LinearGradient(
        colors: [Colors.white, Colors.white10],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ).createShader(
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    Path path = Path();
    path.moveTo(0, -50);
    // path.quadraticBezierTo(110, 10, 0, 70);
    path.cubicTo(100, 20, 50, 30, 0, 70);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RightPaintButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..shader = const LinearGradient(
        colors: [Colors.white70, Colors.white10],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    Path path = Path();
    path.moveTo(size.width, 80);
    path.cubicTo(-70, 0, 0, 5, size.width, -50);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
