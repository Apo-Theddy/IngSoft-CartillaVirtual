import { IsString, IsNotEmpty, IsNumber, IsPositive, IsOptional } from "class-validator"

export class CreateDishDto {
    @IsString()
    @IsNotEmpty()
    DishName: string

    @IsNumber()
    @IsPositive()
    UnitPrice: number

    @IsNumber()
    @IsPositive()
    @IsOptional()
    QuantityAvailable?: number


    @IsNumber()
    @IsPositive()
    @IsOptional()
    CategoryID?: number
}