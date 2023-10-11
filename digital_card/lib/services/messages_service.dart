import 'dart:convert';

import 'package:digital_card/models/message_model.dart';
import 'package:digital_card/models/util_model.dart';
import "package:http/http.dart" as http;

class MessageService extends UtilModel {
  Future<List<Message>> getMessages(int page) async {
    List<Message> messages = [];

    try {
      http.Response response = await http.get(uri("messages?page=$page"));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        messages =
            jsonData.map((message) => Message.fromJson(message)).toList();
      } else {
        handleError("No se pudo obtener los mensajes", response.statusCode);
      }
    } catch (err) {
      handleError("Error al obtener los mensajes", err);
    }

    return messages;
  }
}
