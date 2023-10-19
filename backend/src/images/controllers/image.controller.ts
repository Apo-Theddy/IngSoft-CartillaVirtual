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
    GetImages(): Promise<Image[]> {
        return this.imageService.GetImages();
    }

    @Get(":id")
    GetImage(@Param("id", ParseIntPipe) id: number): Promise<Image> {
        return this.imageService.GetImage(id)
    }

    @Get("dish/:id")
    GetImageByDish(@Param("id", ParseIntPipe) id: number): Promise<Image[]> {
        return this.imageService.GetImagesByDish(id);
    }

    @Post("upload")
    @UseInterceptors(FileInterceptor("file", {
        storage: diskStorage({
            destination: "./uploads",
            filename: renameImage
        }),
        fileFilter: fileFilter
    }))
    UploadImage(@UploadedFile() file: Express.Multer.File, @Body() body: any): Promise<Image> {
        return this.imageService.SaveImage(body.DishID, file.originalname, file.filename, file.path)
    }


    @Delete(":id")
    RemoveImage(@Param("id", ParseIntPipe) id: number) {
        this.imageService.RemoveImage(id)
    }
}