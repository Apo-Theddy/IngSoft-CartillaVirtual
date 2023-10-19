class DishesService {
    constructor() {
        this.url = "http://localhost:3000/api/dishs";
    }

    async getDishes() {
        let dishes = []
        try {
            const response = await axios(this.url);
            dishes = response.data.map((dish) => Dish.fromJson(dish))
        } catch (err) {
            console.log(`Ocurrio un error: ${err}`)
        }
        return dishes;
    }
}