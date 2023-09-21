import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm"
import { Dish } from "src/Dish/entities/dish.entity";
import { Category } from "./entities/category.entity";
import { CategoryController } from "./controllers/category.controller";
import { CategoryService } from "./services/category.service";

@Module({
    imports: [TypeOrmModule.forFeature([Category, Dish])],
    providers: [CategoryService],
    controllers: [CategoryController],
    exports: [CategoryService]
})
export class CategoryModule {

}