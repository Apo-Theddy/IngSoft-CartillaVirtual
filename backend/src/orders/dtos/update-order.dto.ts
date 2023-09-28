import { IsNotEmpty, IsNumber, IsPositive } from "class-validator"

export class UpdateOrderDto {
    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    OrderID: number

    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    DishID: number

    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    Quantity: number
}