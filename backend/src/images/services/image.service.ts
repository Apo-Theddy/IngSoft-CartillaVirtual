
import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Image } from "../entities/image.entity";
import { Repository } from "typeorm";
import { DishService } from "src/dishes/services/dish.service";
import { backgroundRemove } from "../helpers/background_remove.helper";

@Injectable()
export class ImageServices {

    constructor(
        @InjectRepository(Image)
        private imageRepository: Repository<Image>,
        private readonly dishService: DishService
    ) { }

    async GetImages(): Promise<Image[]> {
        let images = await this.imageRepository.find({ where: { IsActive: 1 } })
        return images
    }

    async GetImagesByDish(dishID: number): Promise<Image[]> {
        let images = await this.imageRepository.find({ where: { IsActive: 1, Dish: { DishID: dishID } } })
        return images
    }

    async GetImage(id: number): Promise<Image> {
        let image = await this.imageRepository.findOne({ where: { IsActive: 1, ImageID: id } })
        if (!image) throw new NotFoundException("No se encontro la imagen buscada")
        return image
    }

    async SaveImage(dishID: number, originalname: string, filename: string, path: string): Promise<Image> {
        let newImage = this.imageRepository.create({
            OriginalName: originalname,
            UniqueName: filename,
            Path: `api/${path}`
        })
        let dish = await this.dishService.GetDish(dishID);
        newImage.Dish = dish;
        let [image] = await Promise.all([
            this.imageRepository.save(newImage),
            this.dishService.AddImage(newImage, dish.DishID),
            backgroundRemove(path)
        ])
        return image;
    }

    async RemoveImage(id: number) {
        let image = await this.GetImage(id);
        image.IsActive = 0;
        await this.imageRepository.save(image);
    }
}