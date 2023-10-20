import { ApiProperty } from "@nestjs/swagger"
import { IsNotEmpty, IsNumber, IsPositive } from "class-validator"

export class UpdateOrderDto {

    @ApiProperty()
    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    OrderID: number

    @ApiProperty()
    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    DishID: number

    @ApiProperty()
    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    Quantity: number
}