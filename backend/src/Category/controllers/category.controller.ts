import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post } from "@nestjs/common";
import { CategoryService } from "../services/category.service";
import { Category } from "../entities/category.entity";
import { CreateCategoryDto } from "../dtos/create-category.dto";

@Controller("categories")
export class CategoryController {

    constructor(private readonly categoryService: CategoryService) { }

    // Get all categories
    @Get()
    GetCategories(): Promise<Category[]> {
        return this.categoryService.GetCategories()
    }

    // Get a category by its id
    @Get(":id")
    GetCategory(@Param("id", ParseIntPipe) id: number): Promise<Category> {
        return this.categoryService.GetCategory(id)
    }

    // Add a new category
    @Post()
    AddCategory(@Body() createCategoryDto: CreateCategoryDto): Promise<Category> {
        return this.categoryService.AddCategory(createCategoryDto)
    }

    // Delete a category
    @Delete(":id")
    RemoveCategory(@Param("id", ParseIntPipe) id: number) {
        this.categoryService.RemoveCategory(id)
    }
}