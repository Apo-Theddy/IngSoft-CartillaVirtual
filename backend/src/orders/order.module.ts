import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm"
import { Order, OrderItem } from "./entities/order.entity";
import { Table } from "src/tables/entities/table.entity";
import { OrderService } from "./services/order.service";
import { OrderController } from "./controllers/order.controller";
import { TableModule } from "src/tables/table.module";
import { Dish } from "src/dishes/entities/dish.entity";
import { DishModule } from "src/dishes/dish.module";
import { EmployeesModule } from "src/employees/employees.module";

@Module({
    imports: [TypeOrmModule.forFeature([Order, Dish, Table, OrderItem]), DishModule, TableModule, EmployeesModule],
    providers: [OrderService],
    controllers: [OrderController],
    exports: [OrderService]
})
export class OrderModule { }