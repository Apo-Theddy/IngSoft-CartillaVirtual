import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from "@nestjs/common";
import { DishService } from "../services/dish.service";
import { Dish } from "../entities/dish.entity";
import { CreateDishDto } from "../dtos/create-dish.dto";
import { UpdateDishDto } from "../dtos/update-dish.dto";
import { ApiOperation, ApiResponse, ApiTags } from "@nestjs/swagger";

@Controller("dishs")
@ApiTags("Dishes")
export class DishController {
    constructor(private readonly dishService: DishService) { }

    @Get()
    @ApiOperation({
        summary: "Get all dishes"
    })
    GetDishs(): Promise<Dish[]> {
        return this.dishService.GetDishs()
    }

    @Get(":id")
    @ApiOperation({
        summary: "Get dish by id"
    })
    GetDish(@Param("id", ParseIntPipe) id: number): Promise<Dish> {
        return this.dishService.GetDish(id)
    }

    @Get("search/category/:category")
    @ApiOperation({
        summary: "Search by category",
        description: "Search for a dish by category"
    })
    GetDishesByCategory(@Param("category") category: string): Promise<Dish[]> {
        return this.dishService.GetDishesByCategory(category);
    }

    @Get("search/name/:name")
    @ApiOperation({
        summary: "Search by name",
        description: "Search for a dish by name"
    })
    GetDishesByName(@Param("name") name: string): Promise<Dish[]> {
        return this.dishService.GetDishesByName(name);
    }

    @Post()
    @ApiOperation({
        summary: "Add new dish"
    })
    AddDish(@Body() createDishDto: CreateDishDto): Promise<Dish> {
        return this.dishService.AddDish(createDishDto)
    }

    @Delete(":id")
    @ApiOperation({
        summary: "Remove Dish",
        description: "Remove dish by id"
    })
    RemoveDish(@Param("id", ParseIntPipe) id: number) {
        this.dishService.RemoveDish(id)
    }

    @Delete(":dishID/:categoryID")
    @ApiOperation({
        summary: "Remove Category",
        description: "Remove any category of dish"
    })
    RemoveCategoryDish(
        @Param("dishID", ParseIntPipe) dishID: number,
        @Param("categoryID", ParseIntPipe) categoryID: number) {
        this.dishService.RemoveCategoryDish(dishID, categoryID);
    }

    @Put()
    @ApiOperation({
        summary: "Update dish",
        description: "Update a dish by its id and its new characteristics"
    })
    UpdateDish(@Body() updateDishDto: UpdateDishDto): Promise<Dish> {
        return this.dishService.UpdateDish(updateDishDto);
    }
}