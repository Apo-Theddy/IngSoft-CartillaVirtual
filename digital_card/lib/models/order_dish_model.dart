class OrderDishModel {
  String dishName;
  int dishID;
  int quantity;

  OrderDishModel(this.dishName, this.dishID, this.quantity);

  Map<String, dynamic> toJson() {
    return {"DishID": dishID, "Quantity": quantity};
  }
}
