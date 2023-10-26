import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { SshService } from './sshs/services/ssh.service';
import { swaggerConfig } from './configs/swagger.config';
import { SwaggerModule } from '@nestjs/swagger';
import * as compression from "compression";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  //const sshService: SshService = new SshService();
  const port = process.env.PORT || 3000;

  const document = SwaggerModule.createDocument(app, swaggerConfig);
  SwaggerModule.setup("docs", app, document);

  app.setGlobalPrefix("api")
  app.enableCors();
  app.use(compression())
  app.useGlobalPipes(new ValidationPipe({
    transform: true,
    whitelist: false
  }))
  await app.listen(port);
  //await sshService.CreateTunnesSsh()
}
bootstrap();
