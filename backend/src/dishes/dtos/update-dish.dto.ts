import { IsNumber, IsPositive } from "class-validator"
import { PartialType } from "@nestjs/mapped-types"
import { CreateCategoryDto } from "src/categories/dtos/create-category.dto"
import { ApiProperty } from "@nestjs/swagger"

export class UpdateDishDto extends PartialType(CreateCategoryDto) {

    @ApiProperty()
    @IsNumber()
    @IsPositive()
    DishID: number
}