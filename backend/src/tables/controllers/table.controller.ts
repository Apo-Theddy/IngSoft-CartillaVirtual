import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from "@nestjs/common";
import { Table } from "../entities/table.entity";
import { CreateTableDto } from "../dtos/create-table.dto";
import { UpdateTableDto } from "../dtos/update-table.dto";
import { TableService } from "../services/table.service";
import { ApiOperation, ApiTags } from "@nestjs/swagger";

@Controller("tables")
@ApiTags("Tables")
export class TableController {

    constructor(private readonly tableService: TableService) { }

    @Get()
    @ApiOperation({
        summary: "Get all tables"
    })
    GetTables(): Promise<Table[]> {
        return this.tableService.GetTables()
    }

    @Get(":id")
    @ApiOperation({
        summary: "Get table by id"
    })
    GetTable(@Param("id", ParseIntPipe) id: number): Promise<Table> {
        return this.tableService.GetTable(id)
    }

    @Post()
    @ApiOperation({
        summary: "Create new table"
    })
    AddTable(@Body() createTableDto: CreateTableDto): Promise<Table> {
        return this.tableService.AddTable(createTableDto)
    }

    @Delete(":id")
    @ApiOperation({
        summary: "Delete table",
        description: "Delete table by id"
    })
    RemoveTable(@Param("id") id: number) {
        this.tableService.RemoveTable(id)
    }

    @Put()
    @ApiOperation({
        summary: "Update table",
        description: "Update a table by its id and its new characteristics"
    })
    UpdateTable(@Body() updateTableDto: UpdateTableDto): Promise<Table> {
        return this.tableService.UpdateTable(updateTableDto)
    }
}
