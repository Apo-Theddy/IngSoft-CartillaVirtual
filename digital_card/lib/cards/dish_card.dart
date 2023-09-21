import 'package:digital_card/screens/dish_content_screen.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class DishCard extends StatelessWidget {
  const DishCard({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Get.to(DishContentScreen(id: id), transition: Transition.cupertino);
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: size.width - 80,
            height: size.height * 0.15,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5)),
                ]),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1/4 De pollo a la brasa",
                    style:
                        TextStyle(fontSize: 20, fontFamily: "PlayFairDisplay")),
                Text("S/ 20",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PlayFairDisplay")),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Hero(
                tag: id,
                child: Image.asset("assets/pollo-brasa.png",
                    height: size.height * 0.16),
              )),
        ],
      ),
    );
  }
}
