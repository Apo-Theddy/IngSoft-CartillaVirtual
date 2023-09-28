import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Category } from "src/categories/entities/category.entity";
import { Dish } from "./entities/dish.entity";
import { Table } from "typeorm";
import { CategoryModule } from "src/categories/category.module";
import { DishService } from "./services/dish.service";
import { DishController } from "./controllers/dish.controller";


@Module({
    imports: [TypeOrmModule.forFeature([Dish, Category, Table]), CategoryModule],
    providers: [DishService],
    controllers: [DishController],
    exports: [DishService]
})
export class DishModule { }