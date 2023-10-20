import { IsNotEmpty, IsArray, IsNumber, IsPositive, ArrayMinSize, ValidateNested } from "class-validator"
import { Type } from "class-transformer"
import { OrderDish } from "../interfaces/order.interface"
import { ApiProperty } from "@nestjs/swagger"

export class CreateOrderDto {

    @ApiProperty()
    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    TableID: number

    @ApiProperty()
    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    EmployeeID: number

    @ApiProperty()
    @IsArray()
    @ArrayMinSize(1)
    @ValidateNested()
    @Type(() => OrderDish)
    OrderDishes: OrderDish[]
}