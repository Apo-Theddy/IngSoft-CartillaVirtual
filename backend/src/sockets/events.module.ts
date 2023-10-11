import { Module } from "@nestjs/common"
import { EventsGateway } from "./services/events.gateway";
import { DishModule } from "src/dishes/dish.module";
import { TableModule } from "src/tables/table.module";
import { OrderModule } from "src/orders/order.module";

@Module({
    imports: [DishModule, TableModule, OrderModule],
    providers: [EventsGateway]
})
export class EventsModule { }