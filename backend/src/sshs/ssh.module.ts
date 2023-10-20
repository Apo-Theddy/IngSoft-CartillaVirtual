import { Module } from "@nestjs/common";
import { SshService } from "./services/ssh.service";

@Module({
    providers: [SshService]
})
export class SshModule { }