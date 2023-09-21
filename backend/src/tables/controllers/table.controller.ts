import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from "@nestjs/common";
import { Table } from "../entities/table.entity";
import { CreateTableDto } from "../dtos/create-table.dto";
import { UpdateTableDto } from "../dtos/update-table.dto";
import { TableService } from "../services/table.service";

@Controller("tables")
export class TableController {

    constructor(private readonly tableService: TableService) { }

    @Get()
    GetTables(): Promise<Table[]> {
        return this.tableService.GetTables()
    }

    @Get(":id")
    GetTable(@Param("id", ParseIntPipe) id: number): Promise<Table> {
        return this.tableService.GetTable(id)
    }

    @Post()
    AddTable(@Body() createTableDto: CreateTableDto): Promise<Table> {
        return this.tableService.AddTable(createTableDto)
    }

    @Delete(":id")
    RemoveTable(@Param("id") id: number) {
        this.tableService.RemoveTable(id)
    }

    @Put()
    UpdateTable(@Body() updateTableDto: UpdateTableDto): Promise<Table> {
        return this.tableService.UpdateTable(updateTableDto)
    }
}
