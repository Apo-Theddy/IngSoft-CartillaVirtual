import { ApiProperty } from "@nestjs/swagger";
import { IsString, IsNotEmpty } from "class-validator";

export class CreateEmployeeDto {

    @ApiProperty()
    @IsNotEmpty()
    @IsString()
    Dni: string

    @ApiProperty()
    @IsNotEmpty()
    @IsString()
    Names: string

    @ApiProperty()
    @IsNotEmpty()
    @IsString()
    Lastname: string

    @ApiProperty()
    @IsNotEmpty()
    @IsString()
    MotherLastname: string

    @ApiProperty()
    @IsNotEmpty()
    @IsString()
    DocumentType: string
}