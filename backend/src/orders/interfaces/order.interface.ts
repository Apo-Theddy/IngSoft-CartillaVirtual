import { IsNotEmpty, IsNumber, IsPositive } from "class-validator"

export class OrderDish {
    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    DishID: number

    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    Quantity: number
}