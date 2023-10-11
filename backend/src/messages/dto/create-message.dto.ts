import { IsNotEmpty, IsString } from "class-validator";

export class CreateMessageDto {
    @IsString()
    @IsNotEmpty()
    EmployeeDni: string

    @IsString()
    @IsNotEmpty()
    Content: string
}