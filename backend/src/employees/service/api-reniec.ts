import { ConflictException, HttpStatus, Injectable, InternalServerErrorException } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import axios from "axios";
import { Employees } from "../entities/employees.entity";
import { NotFoundError } from "rxjs";

@Injectable()
export class ApiReniecDataService {

    constructor(private configService: ConfigService) { }

    async findUserByDni(dni: string): Promise<Employees> {
        try {
            let response = await axios.get(`https://api.apis.net.pe/v2/reniec/dni?numero=${dni}`, {
                headers: {
                    "Authorization": `Bearer ${this.configService.get("TOKEN_API_RENIEC")}`
                }
            });
            if (response.status == HttpStatus.OK) {
                let employee: Employees = new Employees();
                let { nombres, apellidoPaterno, apellidoMaterno, tipoDocumento } = response.data;
                employee.Dni = dni;
                employee.Names = nombres;
                employee.Lastname = apellidoPaterno;
                employee.MotherLastname = apellidoMaterno;
                employee.DocumentType = tipoDocumento;
                return employee;
            }
            throw new ConflictException("No se pudo obtener los datos del empleado");
        } catch (err) {
            throw new ConflictException(`Error en el servidor: ${err}`)
        }
    }
}