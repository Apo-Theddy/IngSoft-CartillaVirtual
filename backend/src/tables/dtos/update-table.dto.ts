import { IsNumber, IsPositive } from "class-validator"

import { PartialType } from "@nestjs/mapped-types";
import { CreateTableDto } from "./create-table.dto";
import { ApiProperty } from "@nestjs/swagger";


export class UpdateTableDto extends PartialType(CreateTableDto) {

    @ApiProperty()
    @IsNumber()
    @IsPositive()
    TableID: number
}