import { Dish } from "src/dishes/entities/dish.entity"
import { Employees } from "src/employees/entities/employees.entity"
import { Table } from "src/tables/entities/table.entity"
import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, OneToMany, JoinColumn } from "typeorm"

@Entity({ name: "Orders" })
export class Order {
    @PrimaryGeneratedColumn({ name: "OrderID" })
    OrderID: number


    @Column({
        type: "date",
        name: "OrderDate",
        default: () => "SYSDATETIME()",
        nullable: true
    })
    OrderDate?: string

    @Column({
        type: "bit",
        name: "IsComplete",
        default: 0,
        nullable: true
    })
    IsComplete?: number

    @Column({
        type: "bit",
        name: "IsActive",
        default: 1,
        nullable: true
    })
    IsActive?: number

    @ManyToOne(() => Table, { eager: true })
    @JoinColumn({ name: "TableID" })
    Table: Table

    @OneToMany(() => OrderItem, (orderItem) => orderItem.Order, { eager: true })
    OrderItems: OrderItem[];

    @ManyToOne(() => Employees, { eager: true })
    @JoinColumn({ name: "EmployeeID" })
    Employee: Employees
}

@Entity({ name: "OrderItem" })
export class OrderItem {
    @PrimaryGeneratedColumn()
    OrderItemID: number

    @ManyToOne(() => Order, (order) => order.OrderItems)
    @JoinColumn({ name: "OrderID" })
    Order: Order

    @ManyToOne(() => Dish, { eager: true })
    @JoinColumn({ name: "DishID" })
    Dish: Dish

    @Column({
        type: "tinyint",
        name: "Quantity",
        nullable: false
    })
    Quantity: number
}