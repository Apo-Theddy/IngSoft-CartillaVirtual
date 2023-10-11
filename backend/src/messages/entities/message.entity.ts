import { Employees } from "src/employees/entities/employees.entity";
import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";

@Entity({ name: "Messages" })
export class Message {
    @PrimaryGeneratedColumn()
    MessageID: number

    @ManyToOne(() => Employees, { eager: true })
    @JoinColumn({ name: "EmployeeID" })
    Employee: Employees

    @Column({
        type: "text",
        name: "Content",
        nullable: false
    })
    Content: string

    @Column({
        type: "bit",
        name: "IsActive",
        nullable: true,
        default: 1
    })
    IsActive?: number

    @Column({
        type: "date",
        name: "CreationDate",
        nullable: true,
        default: () => "SYSDATETIME()"
    })
    CreationDate?: string
}
