import { Controller, Delete, Get, Param, Post, ParseIntPipe, Put, Body } from "@nestjs/common";
import { EmployeeService } from "../service/employees.service";
import { Employees } from "../entities/employees.entity";
import { UpdateEmployeeDto } from "../dtos/update-employee.dto";
import { CreateEmployeeDto } from "../dtos/create-employee.dto";

@Controller("employees")
export class EmployeesController {
    constructor(private readonly employeeService: EmployeeService) { }

    @Get()
    GetEmployees(): Promise<Employees[]> {
        return this.employeeService.GetEmployees();
    }

    @Get(":dni")
    GetEmployee(@Param("dni") dni: string): Promise<Employees> {
        return this.employeeService.GetEmployeeData(dni)
    }

    @Get("search/:id")
    GetEmployeeById(@Param("id", ParseIntPipe) id: number): Promise<Employees> {
        return this.employeeService.GetEmployeeById(id);
    }

    @Post(":dni")
    FindDataEmployee(@Param("dni",) dni: string): Promise<Employees> {
        return this.employeeService.FindDataEmployee(dni);
    }

    @Post()
    CreateEmployee(@Body() createEmployeeDto: CreateEmployeeDto) {
        return this.employeeService.CreateEmployee(createEmployeeDto);
    }

    @Delete(":id")
    RemoveEmployee(@Param("id",) id: number) {
        this.employeeService.RemoveEmployee(id)
    }

    @Put()
    UpdateEmployee(@Body() updateEmployeeDto: UpdateEmployeeDto): Promise<Employees> {
        return this.employeeService.UpdateEmployee(updateEmployeeDto);
    }
}