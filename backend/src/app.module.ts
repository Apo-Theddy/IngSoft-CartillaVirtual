import { Module } from '@nestjs/common';
import { TypeOrmModule } from "@nestjs/typeorm"
import { TypeOrmConfig } from './configs/type-orm.config';
import { TableModule } from './tables/table.module';
import { EventsModule } from './sockets/events.module';
import { MulterModule } from '@nestjs/platform-express';
import { join } from 'path';
import { ImageModule } from './images/image.module';
import { OrderModule } from './orders/order.module';
import { CategoryModule } from './categories/category.module';
import { DishModule } from './dishes/dish.module';
import { ServeStaticModule } from '@nestjs/serve-static';

@Module({
  imports: [
    TypeOrmModule.forRoot(TypeOrmConfig),
    MulterModule.register({ dest: join(__dirname, "..", "uploads") }),
    ServeStaticModule.forRoot({ rootPath: join(__dirname, "..", "uploads"), serveRoot: "/api/uploads" }),
    DishModule, CategoryModule, TableModule, OrderModule,
    EventsModule, ImageModule
  ],
})
export class AppModule { }
