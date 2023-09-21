import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm"
import { Table } from "./entities/table.entity";
import { TableService } from "./services/table.service";
import { TableController } from "./controllers/table.controller";
import { Dish } from "src/Dish/entities/dish.entity";
import { DishModule } from "src/Dish/dish.module";

@Module({
    imports: [TypeOrmModule.forFeature([Table, Dish]), DishModule],
    providers: [TableService],
    controllers: [TableController],
    exports: [TableService]
})
export class TableModule { }