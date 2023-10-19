import 'dart:convert';

import 'package:digital_card/models/dish_model.dart';
import 'package:digital_card/models/util_model.dart';
import 'package:http/http.dart' as http;

class DishService extends UtilModel {
  Future<List<Dish>> getDishs() async {
    try {
      http.Response response = await http.get(uri("dishs"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((dish) => Dish.fromJson(dish)).toList();
      } else {
        handleError('Error al obtener los platillos: ', response.statusCode);
        return [];
      }
    } catch (err) {
      handleError("Error al obtener los platillos: ", err);
      return [];
    }
  }

  Future<List<Dish>> getDishsByCategory(String category) async {
    try {
      http.Response response =
          await http.get(uri("dishs/search/category/$category"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((dish) => Dish.fromJson(dish)).toList();
      } else {
        return [];
      }
    } catch (err) {
      handleError("Error al obtener los platillos: ", err);
      return [];
    }
  }

  Future<List<Dish>> getDishesByName(String name) async {
    try {
      http.Response response = await http.get(uri("dishs/search/name/$name"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((dish) => Dish.fromJson(dish)).toList();
      } else {
        return [];
      }
    } catch (err) {
      handleError("Error al obtener los platillos: ", err);
      return [];
    }
  }

  Future<Dish?> getDish(int id) async {
    try {
      http.Response response = await http.get(uri("dishs/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return Dish.fromJson(jsonData);
      } else {
        handleError("Error al obtener el platillo: ", response.statusCode);
      }
    } catch (err) {
      handleError("Ocurrio un error: ", err);
    }
    return null;
  }
}
