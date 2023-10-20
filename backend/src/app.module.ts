import { Module } from '@nestjs/common';
import { TypeOrmModule } from "@nestjs/typeorm"
import { TableModule } from './tables/table.module';
import { EventsModule } from './sockets/events.module';
import { MulterModule } from '@nestjs/platform-express';
import { join } from 'path';
import { ImageModule } from './images/image.module';
import { OrderModule } from './orders/order.module';
import { CategoryModule } from './categories/category.module';
import { DishModule } from './dishes/dish.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { EmployeesModule } from './employees/employees.module';
import { getTypeOrmConfig } from './configs/type-orm.config';
import { MessagesModule } from './messages/messages.module';
import { SshModule } from './sshs/ssh.module';

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      inject: [ConfigService],
      useFactory: async (configService: ConfigService) => await getTypeOrmConfig(configService)
    }),
    ConfigModule.forRoot({
      envFilePath: ".development.env",
      isGlobal: true,
    }),
    MulterModule.register({
      dest: join(__dirname, "..", "uploads")
    }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, "..", "uploads"),
      serveRoot: "/api/uploads"
    }),
    DishModule, CategoryModule, TableModule, OrderModule,
    EventsModule, ImageModule, EmployeesModule, MessagesModule,
    SshModule
  ],
})
export class AppModule { }
