import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post } from "@nestjs/common";
import { CategoryService } from "../services/category.service";
import { Category } from "../entities/category.entity";
import { CreateCategoryDto } from "../dtos/create-category.dto";
import { ApiBody, ApiOperation, ApiParam, ApiResponse, ApiTags } from "@nestjs/swagger";

@Controller("categories")
@ApiTags("Categories")
export class CategoryController {

    constructor(private readonly categoryService: CategoryService) { }
    // Get all categories
    @Get()
    @ApiOperation({
        summary: "Get all categories"
    })
    @ApiResponse({
        status: 200,
        description: "[]",
        isArray: true,
    })
    GetCategories(): Promise<Category[]> {
        return this.categoryService.GetCategories()
    }

    // Get a category by its id
    @Get(":id")
    @ApiOperation({
        summary: "Get category by ID"
    })
    GetCategory(@Param("id", ParseIntPipe) id: number): Promise<Category> {
        return this.categoryService.GetCategory(id)
    }

    // Add a new category
    @Post()
    @ApiOperation({
        summary: "Add new category"
    })
    AddCategory(@Body() createCategoryDto: CreateCategoryDto): Promise<Category> {
        return this.categoryService.AddCategory(createCategoryDto)
    }

    // Delete a category
    @Delete(":id")
    @ApiOperation({
        summary: "Delete a category by Id"
    })
    RemoveCategory(@Param("id", ParseIntPipe) id: number) {
        this.categoryService.RemoveCategory(id)
    }
}