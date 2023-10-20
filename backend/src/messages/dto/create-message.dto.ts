import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsString } from "class-validator";

export class CreateMessageDto {

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    EmployeeDni: string

    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    Content: string
}