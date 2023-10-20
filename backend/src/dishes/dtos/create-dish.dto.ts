import { ApiProperty } from "@nestjs/swagger"
import { IsString, IsNotEmpty, IsNumber, IsPositive, IsOptional, IsArray } from "class-validator"

export class CreateDishDto {

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    DishName: string

    @ApiProperty()
    @IsString()
    @IsOptional()
    Description?: string

    @ApiProperty()
    @IsNumber()
    @IsPositive()
    UnitPrice: number

    @ApiProperty()
    @IsNumber()
    @IsPositive()
    @IsOptional()
    QuantityAvailable?: number

    @ApiProperty()
    @IsArray()
    @IsPositive({ each: true })
    @IsNumber({}, { each: true })
    @IsOptional()
    CategoriesID?: number[]
}