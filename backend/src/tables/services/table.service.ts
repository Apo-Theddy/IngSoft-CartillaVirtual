import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm"
import { Repository } from "typeorm"
import { Table } from "../entities/table.entity";
import { CreateTableDto } from "../dtos/create-table.dto";
import { UpdateTableDto } from "../dtos/update-table.dto";
import { Dish } from "src/Dish/entities/dish.entity";
import { DishService } from "src/Dish/services/dish.service";

@Injectable()
export class TableService {
    constructor(
        @InjectRepository(Table) private tableRepository: Repository<Table>
        , private readonly dishService: DishService
    ) { }

    async GetTables(): Promise<Table[]> {
        let tables = await this.tableRepository.find({ where: { IsActive: 1 } })
        return tables
    }

    async GetTable(id: number): Promise<Table> {
        let table = await this.tableRepository.findOne({ where: { TableID: id, IsActive: 1 } })
        if (!table) throw new NotFoundException(`No se encontro la mesa con el id: '${id}'`)
        return table
    }

    async AddTable(createTableDto: CreateTableDto): Promise<Table> {
        let newTable = this.tableRepository.create(createTableDto)
        return await this.tableRepository.save(newTable)
    }

    async RemoveTable(id: number) {
        let table = await this.GetTable(id)
        table.IsActive = 0
        await this.tableRepository.save(table)
    }

    async UpdateTable(updateTableDto: UpdateTableDto): Promise<Table> {
        let table = await this.GetTable(updateTableDto.TableID)
        Object.assign(table, updateTableDto)
        return await this.tableRepository.save(table)
    }
}