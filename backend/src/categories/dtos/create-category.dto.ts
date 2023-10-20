import { ApiProperty } from "@nestjs/swagger"
import { IsString, IsOptional, IsNotEmpty } from "class-validator"

export class CreateCategoryDto {

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    CategoryName: string

    @ApiProperty()
    @IsOptional()
    @IsString()
    Description?: string
}