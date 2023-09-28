import { ConflictException } from "@nestjs/common"
import { v4 } from "uuid"
import { extname } from "path"

export const renameImage = (req, file, callback) => {
    const filename = file.originalname;
    const ext = extname(filename);
    const uniqueName = v4()
    const newName = `${uniqueName}${ext}`
    callback(null, newName)
}

export const fileFilter = (req, file, callback) => {
    let extensions = /\.(jpg|jepg|png|gif)$/
    if (!file.originalname.match(extensions)) {
        return callback(new ConflictException("Invalid format type"), false)
    }
    callback(null, true);
}

