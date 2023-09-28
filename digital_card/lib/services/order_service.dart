import "dart:convert";

import "package:digital_card/models/order_item_model.dart";
import "package:digital_card/models/order_model.dart";
import "package:digital_card/models/util_model.dart";
import "package:http/http.dart" as http;

class OrderService extends UtilModel {
  Future<List<Order>> getOrders() async {
    try {
      http.Response response = await http.get(uri("orders"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((order) => Order.fromJson(order)).toList();
      } else {
        handleError("No se pudo obtenr las ordenes", response.statusCode);
      }
    } catch (err) {
      handleError("Error al intentar obtener las ordenes", err);
    }

    return [];
  }

  Future<Order?> getOrderByTable(int id) async {
    try {
      http.Response response = await http.get(uri("orders/table/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return Order.fromJson(jsonData);
      } else {
        handleError(
            "No se pudo obtener la orden de esta mesa", response.statusCode);
      }
    } catch (err) {
      handleError("Ocurrio un error al obtener las ordenes", err);
    }
    return null;
  }
}
