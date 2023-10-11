import { Injectable } from "@nestjs/common";
import { Message } from "../entities/message.entity";
import { Repository } from "typeorm";
import { InjectRepository } from "@nestjs/typeorm";
import { CreateMessageDto } from "../dto/create-message.dto";
import { EmployeeService } from "src/employees/service/employees.service";

@Injectable()
export class MessageService {

    constructor(
        @InjectRepository(Message)
        private messageRepository: Repository<Message>,
        private readonly employeeService: EmployeeService
    ) { }

    async GetMessages(page: number): Promise<Message[]> {
        let date = new Date();
        let today = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, "0")}-${date.getDate().toString().padStart(2, "0")}`
        let messages = await this.messageRepository.find({
            where: { IsActive: 1, CreationDate: today }, order: {
                MessageID: "DESC"
            },
            skip: (page - 1) * 10,
            take: 10
        })
        return messages;
    }

    async GetMessagesByEmployeeID(id: number): Promise<Message[]> {
        let messages = await this.messageRepository.find({ where: { Employee: { EmployeeID: id }, IsActive: 1 } })
        return messages;
    }

    async AddMessage(createMessageDto: CreateMessageDto): Promise<Message> {
        let employee = await this.employeeService.GetEmployee(createMessageDto.EmployeeDni);
        if (employee) {
            let newMessage = this.messageRepository.create(createMessageDto);
            newMessage.Employee = employee;
            return await this.messageRepository.save(newMessage);
        }
        return null
    }
}

class DishService {
    url = " https://ccaf-190-236-35-54.ngrok-free.app/api/dishs"
    constructor() { }

    async getDishs() {
        let dishes = await fetch(this.url);
        console.log()
    }
}