import { IsNumber, IsPositive } from "class-validator"
import { PartialType } from "@nestjs/mapped-types"
import { CreateCategoryDto } from "src/categories/dtos/create-category.dto"

export class UpdateDishDto extends PartialType(CreateCategoryDto) {
    @IsNumber()
    @IsPositive()
    DishID: number
}