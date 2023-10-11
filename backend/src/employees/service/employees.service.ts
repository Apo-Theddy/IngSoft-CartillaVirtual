import { ConflictException, Injectable, NotFoundException } from "@nestjs/common";
import { ApiReniecDataService } from "./api-reniec";
import { Employees } from "../entities/employees.entity";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { UpdateEmployeeDto } from "../dtos/update-employee.dto";
import { CreateEmployeeDto } from "../dtos/create-employee.dto";
import { Message } from "src/messages/entities/message.entity";
import { MessageService } from "src/messages/services/message.service";

@Injectable()
export class EmployeeService {

    constructor(
        @InjectRepository(Employees) private employeeRepository: Repository<Employees>,
        private readonly reniecService: ApiReniecDataService,
    ) { }


    async GetEmployees(): Promise<Employees[]> {
        let employees = await this.employeeRepository.find({ where: { IsActive: 1 } });
        return employees;
    }

    async GetEmployee(dni: string): Promise<Employees> {
        let employee = await this.employeeRepository.findOne({ where: { Dni: dni, IsActive: 1 } })
        return employee;
    }

    async GetEmployeeById(id: number): Promise<Employees> {
        let employee = await this.employeeRepository.findOne({ where: { EmployeeID: id, IsActive: 1 } })
        if (!employee) throw new NotFoundException(`No se encontro el empleado con el id: ${id}`)
        return employee;
    }

    async GetEmployeeData(dni: string): Promise<Employees> {
        let employee = await this.GetEmployee(dni)
        if (!employee) throw new NotFoundException(`No se encontro al empleado con el dni: ${dni}`);
        return employee;
    }

    async FindDataEmployee(dni: string): Promise<Employees> {
        try {
            let employee = await this.GetEmployee(dni);
            if (!employee) {
                let newEmployee = this.employeeRepository.create(await this.reniecService.findUserByDni(dni));
                return await this.employeeRepository.save(newEmployee)
            }
            throw new ConflictException(`El empleado con el dni: ${dni} ya se encuentra registrado`)
        }
        catch (err) {
            throw new ConflictException(err);
        }
    }

    async CreateEmployee(createEmployeeDto: CreateEmployeeDto): Promise<Employees> {
        let employee = await this.GetEmployee(createEmployeeDto.Dni);
        if (employee) throw new ConflictException(`El dni: ${createEmployeeDto.Dni} ya se encuentra registrado`)
        let newEmployee = this.employeeRepository.create(createEmployeeDto);
        return await this.employeeRepository.save(newEmployee);
    }

    async RemoveEmployee(id: number) {
        let employee = await this.GetEmployeeById(id)
        employee.IsActive = 0
        await this.employeeRepository.save(employee);
    }

    async UpdateEmployee(updateEmployeeDto: UpdateEmployeeDto): Promise<Employees> {
        let employee = await this.GetEmployeeData(updateEmployeeDto.Dni)
        Object.assign(employee, updateEmployeeDto);
        return await this.employeeRepository.save(employee);
    }

}