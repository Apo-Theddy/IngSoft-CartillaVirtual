import { ApiProperty } from "@nestjs/swagger"
import { IsString, IsNotEmpty } from "class-validator"

export class CreateTableDto {

    @ApiProperty()
        @IsString()
    @IsNotEmpty()
    TableName: string
}