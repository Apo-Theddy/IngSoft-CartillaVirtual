import { IsNumber, IsPositive } from "class-validator"

import { PartialType } from "@nestjs/mapped-types";
import { CreateTableDto } from "./create-table.dto";


export class UpdateTableDto extends PartialType(CreateTableDto) {
    @IsNumber()
    @IsPositive()
    TableID: number
}