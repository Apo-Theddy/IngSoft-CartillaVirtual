import { TypeOrmModuleOptions } from "@nestjs/typeorm"

export const TypeOrmConfig: TypeOrmModuleOptions = {
    type: "mssql",
    host: "localhost",
    username: "sa",
    password: "123",
    autoLoadEntities: true,
    port: 1433,
    synchronize: true,
    database: "digital_card",
    extra: {
        trustServerCertificate: true,
        encrypt: true
    },
}