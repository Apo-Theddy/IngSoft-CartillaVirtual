import { WebSocketGateway, MessageBody, SubscribeMessage, WebSocketServer, OnGatewayInit } from '@nestjs/websockets';
import { Server } from 'socket.io';
import { CreateDishDto } from 'src/dishes/dtos/create-dish.dto';
import { DishService } from 'src/dishes/services/dish.service';

@WebSocketGateway()
export class EventsGateway implements OnGatewayInit {

    constructor(private readonly dishService: DishService) { }

    @WebSocketServer()
    server: Server

    afterInit(server: any) {
        this.server.on("connection", (socket) => {
            console.log(socket.id)
            console.log("Connected")
        })
    }

    @SubscribeMessage("AddNewDish")
    async AddNewDish(@MessageBody() body: CreateDishDto) {
        let newDish = await this.dishService.AddDish(body)
        this.server.emit("AddNewDish", newDish)
    }
}

