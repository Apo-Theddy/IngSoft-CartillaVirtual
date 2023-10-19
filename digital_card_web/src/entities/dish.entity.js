class Dish {
    constructor(dishID, dishName, description, unitPrice, creationDate, isActive, quantityAvailable, categories, images) {
        this.dishID = dishID;
        this.dishName = dishName;
        this.description = description;
        this.unitPrice = unitPrice
        this.creationDate = creationDate
        this.isActive = isActive
        this.quantityAvailable = quantityAvailable
        this.categories = categories
        this.images = images

    }

    static fromJson(json) {
        return new Dish(
            json["DishID"],
            json["DishName"],
            json["Description"],
            json["UnitPrice"],
            json["CreationDate"],
            json["IsActive"],
            json["QuantityAvailable"],
            json["Categories"],
            json["Images"]);
    }
}