import { Controller, UseInterceptors, Post, Get, UploadedFile, Body, Param, ParseIntPipe, Delete } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { diskStorage } from "multer";
import { fileFilter, renameImage } from "../helpers/images.helper";
import { ImageServices } from "../services/image.service";
import { Image } from "../entities/image.entity";

@Controller("images")
export class ImageController {
    constructor(private readonly imageService: ImageServices) { }

    @Get()
    getImages(): Promise<Image[]> {
        return this.imageService.getImages();
    }

    @Get(":id")
    getImage(@Param("id", ParseIntPipe) id: number): Promise<Image> {
        return this.imageService.getImage(id)
    }

    @Get("dish/:id")
    getImageByDish(@Param("id", ParseIntPipe) id: number): Promise<Image[]> {
        return this.imageService.getImagesByDish(id);
    }

    @Post("upload")
    @UseInterceptors(FileInterceptor("file", {
        storage: diskStorage({
            destination: "./uploads",
            filename: renameImage
        }),
        fileFilter: fileFilter
    }))
    uploadImage(@UploadedFile() file: Express.Multer.File, @Body() body: any): Promise<Image> {
        return this.imageService.saveImage(body.DishID, file.originalname, file.filename, file.path)
    }


    @Delete(":id")
    removeImage(@Param("id", ParseIntPipe) id: number) {
        this.imageService.removeImage(id)
    }
}