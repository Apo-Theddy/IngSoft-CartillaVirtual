import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Message } from "./entities/message.entity";
import { ChatGateway } from "./gateways/chat.gateways";
import { MessageService } from "./services/message.service";
import { EmployeesModule } from "src/employees/employees.module";
import { MessageController } from "./controllers/message.controller";

@Module({
    imports: [TypeOrmModule.forFeature([Message]), EmployeesModule],
    controllers: [MessageController],
    providers: [ChatGateway, MessageService],
    exports: [MessageService]
})
export class MessagesModule { }