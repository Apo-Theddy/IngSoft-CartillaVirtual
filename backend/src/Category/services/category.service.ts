import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm"
import { Category } from "../entities/category.entity";
import { Repository } from "typeorm"
import { CreateCategoryDto } from "../dtos/create-category.dto";

@Injectable()
export class CategoryService {
    constructor(@InjectRepository(Category) private categoryRepository: Repository<Category>) { }

    /*
        Get all categories as long as their 'is active' value is equal to 1,
        which indicates that their status is available 
    */
    async GetCategories(): Promise<Category[]> {
        let categories = await this.categoryRepository.find({ where: { IsActive: 1 } })
        return categories
    }

    async GetCategory(id: number): Promise<Category> {
        let category = await this.categoryRepository.findOne({ where: { CategoryID: id, IsActive: 1 } })
        if (!category) throw new NotFoundException(`No se encontro la categoria con el id: '${id}'`)
        return category
    }

    async AddCategory(createCategoryDto: CreateCategoryDto): Promise<Category> {
        let newCategory = this.categoryRepository.create(createCategoryDto)
        return await this.categoryRepository.save(newCategory)
    }

    /* 
        Modifies the value of 'is active' from 1 to 0,
        indicating that the category is not available
    */
    async RemoveCategory(id: number) {
        let category = await this.GetCategory(id)
        category.IsActive = 0
        await this.categoryRepository.save(category)
    }
}