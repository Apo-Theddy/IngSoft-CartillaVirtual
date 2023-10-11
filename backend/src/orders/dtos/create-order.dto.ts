import { IsNotEmpty, IsArray, IsNumber, IsPositive, ArrayMinSize, ValidateNested } from "class-validator"
import { Type } from "class-transformer"
import { OrderDish } from "../interfaces/order.interface"

export class CreateOrderDto {

    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    TableID: number

    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    EmployeeID: number

    @IsArray()
    @ArrayMinSize(1)
    @ValidateNested()
    @Type(() => OrderDish)
    OrderDishes: OrderDish[]
}