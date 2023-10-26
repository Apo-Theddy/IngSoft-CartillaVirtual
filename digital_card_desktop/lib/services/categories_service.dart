import "dart:convert";

import "package:digital_card_desktop/models/category_model.dart";
import "package:digital_card_desktop/models/util_model.dart";
import "package:http/http.dart" as http;

class CategoriesService extends UtilModel {
  Future<List<Category>> getCategories() async {
    try {
      http.Response response = await http.get(uri("categories"));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Category.fromJson(json)).toList();
      } else {
        handleError("No se pudo obtener las categorias: ", response.statusCode);
      }
    } catch (err) {
      handleError("Error al obtener las mesas: ", err);
    }
    return [];
  }

  Future<void> removeCategoryOfDish(int dishID, int categoryID) async {
    try {
      http.Response response =
          await http.delete(uri("dishs/$dishID/$categoryID"));

      if (response.statusCode != 200) {
        handleError(
            "Ocurrio un error al eliminar la categoria", response.statusCode);
        return;
      }
    } catch (err) {
      handleError("Error", err);
    }
  }
}
