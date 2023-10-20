import { Controller, UseInterceptors, Post, Get, UploadedFile, Body, Param, ParseIntPipe, Delete } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { diskStorage } from "multer";
import { fileFilter, renameImage } from "../helpers/images.helper";
import { ImageServices } from "../services/image.service";
import { Image } from "../entities/image.entity";
import { ApiOperation, ApiTags } from "@nestjs/swagger";

@Controller("images")
@ApiTags("Images")
export class ImageController {
    constructor(private readonly imageService: ImageServices) { }

    @Get()
    @ApiOperation({
        summary: "Get all images"
    })
    GetImages(): Promise<Image[]> {
        return this.imageService.GetImages();
    }

    @Get(":id")
    @ApiOperation({
        summary: "Get image by id"
    })
    GetImage(@Param("id", ParseIntPipe) id: number): Promise<Image> {
        return this.imageService.GetImage(id)
    }

    @Get("dish/:id")
    @ApiOperation({
        summary: "Get image of dish",
        description: "Get the image of a plate by its id"
    })
    GetImageByDish(@Param("id", ParseIntPipe) id: number): Promise<Image[]> {
        return this.imageService.GetImagesByDish(id);
    }

    @Post("upload")
    @ApiOperation({
        summary: "Upload new image",
        description: "Upload a new image on a saucer by id"
    })
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
    @ApiOperation({
        summary: "Delete image",
        description: "Delete image by id"
    })
    RemoveImage(@Param("id", ParseIntPipe) id: number) {
        this.imageService.RemoveImage(id)
    }
}