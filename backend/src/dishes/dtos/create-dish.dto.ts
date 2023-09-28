import { IsString, IsNotEmpty, IsNumber, IsPositive, IsOptional, IsArray } from "class-validator"

export class CreateDishDto {
    @IsString()
    @IsNotEmpty()
    DishName: string

    @IsString()
    @IsOptional()
    Description?: string

    @IsNumber()
    @IsPositive()
    UnitPrice: number

    @IsNumber()
    @IsPositive()
    @IsOptional()
    QuantityAvailable?: number



    @IsArray()
    @IsPositive({ each: true })
    @IsNumber({}, { each: true })
    @IsOptional()
    CategoriesID?: number[]
}