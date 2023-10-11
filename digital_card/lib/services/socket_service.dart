import "dart:convert";

import "package:digital_card/constants/contants_vars.dart";
import "package:digital_card/models/dish_model.dart";
import "package:digital_card/screens/dishes_screen.dart";
import "package:flutter/material.dart";
import "package:socket_io_client/socket_io_client.dart" as IO;

class SocketService {
  late IO.Socket _socket;

  ValueNotifier<List<Dish>> dishes = ValueNotifier<List<Dish>>([]);
  SocketService() {
    _socket = IO.io(url, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true
    });

    _socket.onConnect((_) {
      print("Connected to the server");
    });

    _socket.onDisconnect((_) {
      print("Disconnected from the server");
    });

    _socket.on('AddDish', (data) {
      Map<String, dynamic> jsonData = json.decode(json.encode(data));
      jsonData.addAll({"Images": []});
      dishes.value.add(Dish.fromJson(jsonData));
      dishes.notifyListeners();
    });
    // Se suscribe al evento 'UpdateDish' y actualiza el valor de dishes
    _socket.on('UpdateDish', (data) {
      getDishes();
    });
  }
  Future<void> getDishes() async {
    dishes.value = await dishService.getDishs();
    dishes.notifyListeners();
  }

  IO.Socket get socket => _socket;

  void close() {
    _socket.dispose();
  }
}
