import { IsString, IsNotEmpty } from "class-validator"

export class CreateTableDto {
    @IsString()
    @IsNotEmpty()
    TableName: string
}