import { Injectable, NotFoundException } from "@nestjs/common";
import { Dish } from "../entities/dish.entity";
import { InjectRepository } from "@nestjs/typeorm"
import { Repository } from "typeorm";
import { CreateDishDto } from "../dtos/create-dish.dto";
import { CategoryService } from "src/Category/services/category.service";
import { UpdateDishDto } from "../dtos/update-dish.dto";

@Injectable()
export class DishService {
    constructor(
        @InjectRepository(Dish)
        private dishRepository: Repository<Dish>,
        private readonly categoryService: CategoryService
    ) { }


    async GetDishs(): Promise<Dish[]> {
        let dishes = await this.dishRepository.find({
            where: { IsActive: 1 }
        })
        return dishes
    }

    async GetDish(id: number): Promise<Dish> {
        let dish = await this.dishRepository.findOne({ where: { DishID: id, IsActive: 1 } })
        if (!dish) throw new NotFoundException(`No se encontro el platillo con el id:'${id}'`)
        return dish
    }

    async AddDish(createDishDto: CreateDishDto): Promise<Dish> {
        let category = null
        if (createDishDto.CategoryID) category = await this.categoryService.GetCategory(createDishDto.CategoryID)
        let newDish = this.dishRepository.create(createDishDto)
        newDish.Category = category
        return await this.dishRepository.save(newDish)
    }

    async RemoveDish(id: number) {
        let dish = await this.GetDish(id)
        dish.IsActive = 0
        await this.dishRepository.save(dish)
    }

    async UpdateDish(updateDishDto: UpdateDishDto): Promise<Dish> {
        let dish = await this.GetDish(updateDishDto.DishID)
        Object.assign(dish, updateDishDto)
        return await this.dishRepository.save(dish)
    }

    async ConsumeDish(id: number): Promise<Dish> {
        let dish = await this.GetDish(id)
        if (dish.QuantityAvailable != null && dish.QuantityAvailable > 0) {
            --dish.QuantityAvailable
            return await this.dishRepository.save(dish)
        }
        return null
    }

    async ConsumeDishByQuantity(id: number, quantity: number): Promise<Dish> {
        let dish = await this.GetDish(id)
        if (dish.QuantityAvailable != null && dish.QuantityAvailable > 0 && quantity <= dish.QuantityAvailable) {
            dish.QuantityAvailable -= quantity
            return await this.dishRepository.save(dish)
        }
        return null
    }

    async UnconsumeDish(id: number) {
        let dish = await this.GetDish(id)
        if (dish.QuantityAvailable != null && dish.QuantityAvailable >= 0) {
            ++dish.QuantityAvailable
            await this.dishRepository.save(dish)
        }
    }
}