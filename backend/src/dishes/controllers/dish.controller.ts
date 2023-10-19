import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from "@nestjs/common";
import { DishService } from "../services/dish.service";
import { Dish } from "../entities/dish.entity";
import { CreateDishDto } from "../dtos/create-dish.dto";
import { UpdateDishDto } from "../dtos/update-dish.dto";

@Controller("dishs")
export class DishController {
    constructor(private readonly dishService: DishService) { }

    @Get()
    GetDishs(): Promise<Dish[]> {
        return this.dishService.GetDishs()
    }

    @Get(":id")
    GetDish(@Param("id", ParseIntPipe) id: number): Promise<Dish> {
        return this.dishService.GetDish(id)
    }

    @Get("search/category/:category")
    GetDishesByCategory(@Param("category") category: string): Promise<Dish[]> {
        return this.dishService.GetDishesByCategory(category);
    }

    @Get("search/name/:name")
    GetDishesByName(@Param("name") name: string): Promise<Dish[]> {
        return this.dishService.GetDishesByName(name);
    }

    @Post()
    AddDish(@Body() createDishDto: CreateDishDto): Promise<Dish> {
        return this.dishService.AddDish(createDishDto)
    }

    @Delete(":id")
    RemoveDish(@Param("id", ParseIntPipe) id: number) {
        this.dishService.RemoveDish(id)
    }

    @Put()
    UpdateDish(@Body() updateDishDto: UpdateDishDto): Promise<Dish> {
        return this.dishService.UpdateDish(updateDishDto);
    }

    @Put(":id")
    ConsumeDish(@Param("id", ParseIntPipe) id: number) {
        this.dishService.ConsumeDish(id)
    }
}