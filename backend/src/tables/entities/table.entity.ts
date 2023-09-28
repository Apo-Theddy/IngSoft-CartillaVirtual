import { Order } from "src/orders/entities/order.entity"
import { Entity, PrimaryGeneratedColumn, Column, JoinColumn, OneToMany, OneToOne } from "typeorm"

@Entity({ name: "Tables" })
export class Table {

    @PrimaryGeneratedColumn({ name: "TableID" })
    TableID: number

    @Column({
        type: "varchar",
        name: "TableName",
        length: 100,
        nullable: false
    })
    TableName: string

    @Column({
        type: "date",
        name: "CreationDate",
        default: () => "SYSDATETIME()",
        nullable: true
    })
    CreationDate?: string

    @Column({
        type: "bit",
        name: "IsActive",
        default: 1,
        nullable: true
    })
    IsActive?: number

    @OneToMany(() => Order, (order) => order.Table)
    Order: Order
}