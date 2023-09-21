import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm"
import { Order, OrderItem } from "./entities/order.entity";
import { Dish } from "src/Dish/entities/dish.entity";
import { Table } from "src/tables/entities/table.entity";
import { OrderService } from "./services/order.service";
import { OrderController } from "./controllers/order.controller";
import { DishModule } from "src/Dish/dish.module";
import { TableModule } from "src/tables/table.module";

@Module({
    imports: [TypeOrmModule.forFeature([Order, Dish, Table, OrderItem]), DishModule, TableModule],
    providers: [OrderService],
    controllers: [OrderController]
})
export class OrderModule { }