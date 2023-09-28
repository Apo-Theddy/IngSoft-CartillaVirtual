import { readdirSync } from "fs"
const sharp = require("sharp")
// import { sharp } from "sharp"
import { Rembg } from "rembg-node"

export const backgroundRemove = async (path: string) => {
    const input = sharp(path)
    const rembg = new Rembg({ logging: true })
    const output = await rembg.remove(input)
    await output.trim().webp().toFile(path)
}