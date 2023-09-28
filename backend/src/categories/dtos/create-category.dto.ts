import { IsString, IsOptional, IsNotEmpty } from "class-validator"

export class CreateCategoryDto {
    @IsString()
    @IsNotEmpty()
    CategoryName: string

    @IsOptional()
    @IsString()
    Description?: string
}