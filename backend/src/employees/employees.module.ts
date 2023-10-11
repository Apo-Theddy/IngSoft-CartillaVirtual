import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Employees } from "./entities/employees.entity";
import { ApiReniecDataService } from "./service/api-reniec";
import { EmployeeService } from "./service/employees.service";
import { EmployeesController } from "./controllers/employees.controller";

@Module({
    imports: [TypeOrmModule.forFeature([Employees])],
    controllers: [EmployeesController],
    providers: [EmployeeService, ApiReniecDataService],
    exports: [EmployeeService]
})
export class EmployeesModule { }