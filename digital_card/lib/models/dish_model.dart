import 'package:digital_card/models/category_model.dart';
import 'package:digital_card/models/image_model.dart';

class Dish {
  int dishID;
  String dishName;
  String? description;
  double unitPrice;
  String? creationDate;
  bool? isActive;
  int? quantityAvailable;
  List<Category>? categories;
  List<Image>? images;

  Dish(
      this.dishID,
      this.dishName,
      this.description,
      this.unitPrice,
      this.creationDate,
      this.isActive,
      this.quantityAvailable,
      this.categories,
      this.images);

  factory Dish.fromJson(Map<String, dynamic> json) {
    List<Category>? categories = (json["Categories"] as List)
        .map((category) => Category.fromJson(category))
        .toList();

    List<Image>? images =
        (json["Images"] as List).map((image) => Image.fromJson(image)).toList();

    return Dish(
        json["DishID"],
        json["DishName"],
        json["Description"],
        double.parse("${json["UnitPrice"]}"),
        json["CreationDate"],
        json["IsActive"],
        json["QuantityAvailabre"],
        categories,
        images);
  }
}
