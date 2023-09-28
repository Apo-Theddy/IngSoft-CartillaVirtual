import { Module } from "@nestjs/common";
import { ImageController } from "./controllers/image.controller";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Image } from "./entities/image.entity";
import { Dish } from "src/dishes/entities/dish.entity";
import { DishModule } from "src/dishes/dish.module";
import { ImageServices } from "./services/image.service";

@Module({
    imports: [TypeOrmModule.forFeature([Image, Dish]), DishModule],
    providers: [ImageServices],
    controllers: [ImageController],
})
export class ImageModule { }