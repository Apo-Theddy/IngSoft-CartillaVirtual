import { Module } from '@nestjs/common';
import { TypeOrmModule } from "@nestjs/typeorm"
import { TypeOrmConfig } from './configs/type-orm.config';
import { CategoryModule } from './Category/category.module';
import { DishModule } from './Dish/dish.module';
import { TableModule } from './tables/table.module';
import { OrderModule } from './Order/order.module';

@Module({
  imports: [TypeOrmModule.forRoot(TypeOrmConfig),
    DishModule, CategoryModule, TableModule, OrderModule
  ],
})
export class AppModule { }
