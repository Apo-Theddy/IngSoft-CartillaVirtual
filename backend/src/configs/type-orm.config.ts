import { ConfigService } from "@nestjs/config"
import { TypeOrmModuleOptions } from "@nestjs/typeorm"

export const getTypeOrmConfig = async (configService: ConfigService): Promise<TypeOrmModuleOptions> => {
    return {
        type: "mssql",
        host: "localhost",
        username: configService.get("USER_DATABASE"),
        password: configService.get("PASSWORD_DATABASE"),
        autoLoadEntities: true,
        port: parseInt(configService.get("PORT_DATABASE"), 10) || 1433,
        synchronize: true,
        database: configService.get("NAME_DATABASE"),
        extra: {
            trustServerCertificate: true,
            encrypt: true
        }
    };
}