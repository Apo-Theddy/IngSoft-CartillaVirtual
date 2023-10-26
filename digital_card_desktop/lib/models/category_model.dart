class Category {
  int categoryID;
  String categoryName;
  bool? isActive;
  String? creationDate;

  Category(
      this.categoryID, this.categoryName, this.isActive, this.creationDate);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json["CategoryID"], json["CategoryName"], json["IsActive"],
        json["CreationDate"]);
  }
}
