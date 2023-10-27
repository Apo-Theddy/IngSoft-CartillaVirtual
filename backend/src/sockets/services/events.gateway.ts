import { WebSocketGateway, MessageBody, SubscribeMessage, WebSocketServer, OnGatewayInit } from '@nestjs/websockets';
import { Server } from 'socket.io';
import { CreateDishDto } from 'src/dishes/dtos/create-dish.dto';
import { Dish } from 'src/dishes/entities/dish.entity';
import { DishService } from 'src/dishes/services/dish.service';
import { CreateOrderDto } from 'src/orders/dtos/create-order.dto';
import { OrderService } from 'src/orders/services/order.service';
import { CreateTableDto } from 'src/tables/dtos/create-table.dto';
import { TableService } from 'src/tables/services/table.service';

@WebSocketGateway({
    cors: {
        origin: "*"
    }
})
export class EventsGateway implements OnGatewayInit {

    constructor(
        private readonly dishService: DishService,
        private readonly tableService: TableService,
        private readonly orderService: OrderService
    ) { }

    @WebSocketServer()
    server: Server

    afterInit(server: any) {
        this.server.on("connection", (socket) => {
            console.log(socket.id)
            console.log("Connected")
        })
    }

    @SubscribeMessage("AddDish")
    async AddDish(@MessageBody() body: CreateDishDto) {
        const dish = await this.dishService.AddDish
            (body);
        this.server.emit("UpdateDish", dish);
    }

    @SubscribeMessage("AddTable")
    async AddTable(@MessageBody() body: CreateTableDto) {
        const table = await this.tableService.AddTable(body);
        this.server.emit("AddTable", table);
    }

    @SubscribeMessage("AddOrder")
    async AddOrder(@MessageBody() body: CreateOrderDto) {
        await this.orderService.AddOrder(body);
        let dish = await this.dishService.GetDish(body.OrderDishes[0].DishID);
        this.server.emit("UpdateDish", dish);
    }

    @SubscribeMessage("SetOrderComplete")
    async SetOrderComplete(@MessageBody() body: any) {
        await this.orderService.SetOrderComplete(body)
        this.server.emit("UpdateListOrders")
    }
}

