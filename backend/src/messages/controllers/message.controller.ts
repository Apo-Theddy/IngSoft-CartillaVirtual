import { Body, Controller, Get, Param, ParseIntPipe, Post, Query } from "@nestjs/common";
import { MessageService } from "../services/message.service";
import { Message } from "../entities/message.entity";
import { CreateMessageDto } from "../dto/create-message.dto";

@Controller("messages")
export class MessageController {

    constructor(private readonly messageService: MessageService) { }

    @Get("")
    async GetMessages(@Query("page", ParseIntPipe) page: number): Promise<Message[]> {
        return this.messageService.GetMessages(page)
    }

    @Get(":id")
    async GetMessagesByEmployeeID(@Param("id", ParseIntPipe) id: number): Promise<Message[]> {
        return this.messageService.GetMessagesByEmployeeID(id);
    }

    @Post()
    async AddMessage(@Body() createMessageDto: CreateMessageDto): Promise<Message> {
        return this.messageService.AddMessage(createMessageDto)
    }
}

