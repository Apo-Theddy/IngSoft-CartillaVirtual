import { Image } from "src/images/entities/image.entity";
import { Category } from "src/categories/entities/category.entity";

import { Entity, PrimaryGeneratedColumn, Column, JoinColumn, ManyToOne, JoinTable, ManyToMany, OneToMany } from "typeorm";

@Entity({ name: "Dishs" })
export class Dish {
    @PrimaryGeneratedColumn({ name: "DishID" })
    DishID: number

    @Column({
        type: "varchar",
        name: "DishName",
        length: 150,
        nullable: false
    })
    DishName: string

    @Column({
        type: "text",
        name: "Description",
        nullable: true
    })
    Description?: string

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


    @OneToMany(() => Image, (image) => image.Dish, { nullable: true, eager: true })
    Images?: Image[]

    @Column({
        name: "QuantityAvailable",
        type: "int",
        nullable: true
    })
    QuantityAvailable?: number

    @ManyToMany(() => Category, { nullable: true, eager: true })
    @JoinTable({
        name: "Dish_Category",
        joinColumn: {
            name: "DishID",
            referencedColumnName: "DishID"
        },
        inverseJoinColumn: {
            name: "CategoryID",
            referencedColumnName: "CategoryID"
        }
    })
    Categories?: Category[]
}