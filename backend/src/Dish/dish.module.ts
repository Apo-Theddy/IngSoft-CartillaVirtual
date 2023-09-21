import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Dish } from "./entities/dish.entity";
import { DishService } from "./services/dish.service";
import { DishController } from "./controllers/dish.controller";
import { Category } from "src/Category/entities/category.entity";
import { CategoryModule } from "src/Category/category.module";
import { Table } from "src/tables/entities/table.entity";

@Module({
    imports: [TypeOrmModule.forFeature([Dish, Category, Table]), CategoryModule],
    providers: [DishService],
    controllers: [DishController],
    exports: [DishService]
})
export class DishModule { }