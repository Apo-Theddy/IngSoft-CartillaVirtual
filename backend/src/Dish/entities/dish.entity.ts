import { Category } from "src/Category/entities/category.entity";
import { Order } from "src/Order/entities/order.entity";
import { Table } from "src/tables/entities/table.entity";
import { Entity, PrimaryGeneratedColumn, Column, JoinColumn, ManyToOne, JoinTable, ManyToMany } from "typeorm";

@Entity({ name: "Dishs" })
export class Dish {
    @PrimaryGeneratedColumn({ name: "DishID" })
    DishID: number

    @Column({
        name: "DishName",
        type: "varchar",
        length: 150,
        nullable: false
    })
    DishName: string

    @Column({
        name: "UnitPrice",
        type: "money",
        nullable: false
    })
    UnitPrice: number

    @Column({
        name: "CreationDate",
        type: "date",
        nullable: true,
        default: () => "SYSDATETIME()",
    })
    CreationDate?: string

    @Column({
        name: "IsActive",
        type: "bit",
        nullable: true,
        default: 1,
    })
    IsActive?: number

    @Column({
        name: "QuantityAvailable",
        type: "int",
        nullable: true
    })
    QuantityAvailable?: number

    TimesOrdered?: number

    @ManyToMany(() => Category, { nullable: true, eager: true })
    @JoinTable({
        name: "Dish_Category", joinColumn: {
            name: "DishID",
            referencedColumnName: "DishID"
        }, inverseJoinColumn: {
            name: "CategoryID",
            referencedColumnName: "CategoryID"
        }
    })
    Category?: Category[]
}