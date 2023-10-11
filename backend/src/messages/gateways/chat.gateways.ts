import { MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from "@nestjs/websockets";
import { Socket } from "socket.io";
import { CreateMessageDto } from "../dto/create-message.dto";
import { MessageService } from "../services/message.service";
import { UsePipes, ValidationPipe } from "@nestjs/common";

@WebSocketGateway({
    cors: { origin: "*" }
})
export class ChatGateway {

    constructor(private readonly messageService: MessageService) { }

    @WebSocketServer()
    private server: Socket

    @SubscribeMessage("SendMessage")
    @UsePipes(new ValidationPipe({ always: true, transform: true, whitelist: true }))
    async SendMessage(@MessageBody() body: CreateMessageDto) {
        let newMessage = await this.messageService.AddMessage(body);
        this.server.emit("SendMessage", newMessage)
    }
}
