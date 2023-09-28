import 'package:flutter/material.dart';
import "package:flutter_hooks/flutter_hooks.dart";
import "package:intl/intl.dart";

class AddDishComponent extends HookWidget {
  const AddDishComponent({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final countDish = useState<int>(1);
    final totalPrice = countDish.value * 15.5; // Calcula el precio sin formato
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
                child: Hero(
                    tag: id, child: Image.asset("assets/pollo-brasa.png"))),
            // Dish information
            const Text("1/4 De Pollo a la brasa",
                style: TextStyle(
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
                  child: Row(children: [
                    Expanded(
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black12),
                                elevation: MaterialStatePropertyAll(0),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25)),
                                  ),
                                )),
                            onPressed: () =>
                                {if (countDish.value > 1) countDish.value--},
                            child: Container(
                              height: 50,
                              child:
                                  Icon(Icons.remove, color: Color(0xff183365)),
                            ))),
                    Expanded(
                        child: Text(
                      "${countDish.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff183365)),
                    )),
                    Expanded(
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black12),
                                elevation: MaterialStatePropertyAll(0),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                                  ),
                                )),
                            onPressed: () => countDish.value++,
                            child: const SizedBox(
                              height: 50,
                              child: Icon(
                                Icons.add,
                                color: Color(0xff183365),
                              ),
                            ))),
                  ]),
                ),
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
                print("add to card");
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
                style: TextStyle(color: Color(0xff183365), fontSize: 19)),
            const SizedBox(height: 10),
            const Text(
                "Nulla deserunt voluptate sunt eu id minim elit commodo elit nulla. Mollit adipisicing Lorem laboris excepteur laboris. Nostrud commodo excepteur nisi culpa quis ex est dolore deserunt. Nulla commodo cupidatat sit minim ex amet culpa culpa sunt eu. Adipisicing esse in culpa et proident ullamco. Nisi ad ipsum elit enim magna amet.",
                style: TextStyle(fontSize: 17))
          ]),
        ),
      ),
    );
  }
}
