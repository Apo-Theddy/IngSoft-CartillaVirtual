import 'dart:convert';

import 'package:digital_card/models/table_model.dart';
import 'package:digital_card/models/util_model.dart';
import "package:http/http.dart" as http;

class TablesService extends UtilModel {
  Future<List<TableModel>> getTables() async {
    try {
      http.Response response = await http.get(uri("tables"));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => TableModel.fromJson(json)).toList();
      } else {
        handleError("No se pudo obtener las mesas: ", response.statusCode);
      }
    } catch (err) {
      handleError("Error al obtener las mesas: ", err);
    }
    return [];
  }

  Future<TableModel?> getTable(int id) async {
    try {
      http.Response response = await http.get(uri("tables/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return TableModel.fromJson(jsonData);
      } else {
        handleError("No se pudo obtener la mesa: ", response.statusCode);
      }
    } catch (err) {
      handleError("Error al obtener una mesa: ", err);
    }
    return null;
  }
}
