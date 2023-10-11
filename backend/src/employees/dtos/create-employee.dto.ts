import { IsString, IsNotEmpty } from "class-validator";

export class CreateEmployeeDto {
    @IsNotEmpty()
    @IsString()
    Dni: string

    @IsNotEmpty()
    @IsString()
    Names: string

    @IsNotEmpty()
    @IsString()
    Lastname: string

    @IsNotEmpty()
    @IsString()
    MotherLastname: string

    @IsNotEmpty()
    @IsString()
    DocumentType: string
}