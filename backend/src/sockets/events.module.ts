import { Module } from "@nestjs/common"
import { EventsGateway } from "./services/events.gateway";
import { DishModule } from "src/dishes/dish.module";

@Module({
    imports: [DishModule],
    providers: [EventsGateway]
})
export class EventsModule { }