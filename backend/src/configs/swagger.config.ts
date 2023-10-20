import { DocumentBuilder } from "@nestjs/swagger";

export const swaggerConfig = new DocumentBuilder()
    .setTitle("Digital Card Api")
    .setDescription("Documentacion de la api")
    .setVersion("1.0")
    .build();