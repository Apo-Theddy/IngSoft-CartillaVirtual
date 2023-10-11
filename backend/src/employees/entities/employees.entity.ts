import { Message } from "src/messages/entities/message.entity";
import { Order } from "src/orders/entities/order.entity";
import { Entity, PrimaryGeneratedColumn, Column, OneToMany, Index } from "typeorm";

@Entity({ name: "Employees" })
export class Employees {

    @PrimaryGeneratedColumn()
    EmployeeID: number

    @Column({
        type: "char",
        length: 8,
        nullable: false
    })
    @Index({ unique: true })
    Dni: string

    @Column({
        type: "varchar",
        name: "Names",
        nullable: false
    })
    Names: string;

    @Column({
        type: "varchar",
        name: "Lastname",
        nullable: false
    })
    Lastname: string;

    @Column({
        type: "varchar",
        name: "MotherLastname",
        nullable: false
    })
    MotherLastname: string

    @Column({
        type: "varchar",
        name: "DocumentType",
        nullable: false,
        length: 1
    })
    DocumentType: string

    @Column({
        type: "date",
        name: "CreationDate",
        nullable: true,
        default: () => "SYSDATETIME()"
    })
    CreationDate?: string;

    @Column({
        type: "bit",
        name: "IsActive",
        nullable: true,
        default: 1
    })
    IsActive?: number;

    @OneToMany(() => Order, (order) => order.Employee)
    Orders: Order[]

    @OneToMany(() => Message, (message) => message.Employee)
    Messages: Message[]
}   