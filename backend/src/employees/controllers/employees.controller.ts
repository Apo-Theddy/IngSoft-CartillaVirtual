import { Controller, Delete, Get, Param, Post, ParseIntPipe, Put, Body } from "@nestjs/common";
import { EmployeeService } from "../service/employees.service";
import { Employees } from "../entities/employees.entity";
import { UpdateEmployeeDto } from "../dtos/update-employee.dto";
import { CreateEmployeeDto } from "../dtos/create-employee.dto";
import { ApiOperation, ApiTags } from "@nestjs/swagger";

@Controller("employees")
@ApiTags("Employees")
export class EmployeesController {
    constructor(private readonly employeeService: EmployeeService) { }

    @Get()
    @ApiOperation({
        summary: "Get all employees"
    })
    GetEmployees(): Promise<Employees[]> {
        return this.employeeService.GetEmployees();
    }

    @Get(":dni")
    @ApiOperation({
        summary: "Get employee by dni"
    })
    GetEmployee(@Param("dni") dni: string): Promise<Employees> {
        return this.employeeService.GetEmployeeData(dni)
    }

    @Get("search/:id")
    @ApiOperation({
        summary: "Get employee by id"
    })
    GetEmployeeById(@Param("id", ParseIntPipe) id: number): Promise<Employees> {
        return this.employeeService.GetEmployeeById(id);
    }

    @Post(":dni")
    @ApiOperation({
        summary: "Add new employee",
        description: "Add a new employee by his information obtained from an external API"
    })
    FindDataEmployee(@Param("dni",) dni: string): Promise<Employees> {
        return this.employeeService.FindDataEmployee(dni);
    }

    @Post()
    @ApiOperation({
        summary: "Add new employee",
        description: "Add a new employee based on the information entered"
    })
    CreateEmployee(@Body() createEmployeeDto: CreateEmployeeDto) {
        return this.employeeService.CreateEmployee(createEmployeeDto);
    }

    @Delete(":id")
    @ApiOperation({
        summary: "Delete employee",
        description: "Delete employee by id"
    })
    RemoveEmployee(@Param("id",) id: number) {
        this.employeeService.RemoveEmployee(id)
    }

    @Put()
    @ApiOperation({
        summary: "Update employee",
        description: "Update an employee for your id and your new information"
    })
    UpdateEmployee(@Body() updateEmployeeDto: UpdateEmployeeDto): Promise<Employees> {
        return this.employeeService.UpdateEmployee(updateEmployeeDto);
    }
}