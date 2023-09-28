import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm"
import { Category } from "./entities/category.entity";
import { CategoryController } from "./controllers/category.controller";
import { CategoryService } from "./services/category.service";
import { Dish } from "src/dishes/entities/dish.entity";

@Module({
    imports: [TypeOrmModule.forFeature([Category, Dish])],
    providers: [CategoryService],
    controllers: [CategoryController],
    exports: [CategoryService]
})
export class CategoryModule {

}