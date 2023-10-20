import { Injectable } from "@nestjs/common";
import { exec } from "child_process";

@Injectable()
export class SshService {
    async CreateTunnesSsh() {
        return new Promise<void>((res, rej) => {
            const command = 'ssh -R 80:localhost:3000 serveo.net';
            const sshProcess = exec(command);
            sshProcess.on("exit", (code, signal) => {
                if (code == 0) res();
                else rej(`No se pudo completar el comando SSH, codigo: ${code}`)
            });
            sshProcess.stdout.on("data", (data) => {
                console.log(`${data.split(" ")[data.split(" ").length - 1]}`)
            });
        });
    }
}