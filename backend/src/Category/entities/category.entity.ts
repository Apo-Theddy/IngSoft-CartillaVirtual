import { Dish } from "src/Dish/entities/dish.entity"
import { Entity, PrimaryGeneratedColumn, Column, OneToMany, JoinColumn } from "typeorm"


@Entity({ name: "Categories" })
export class Category {
    @PrimaryGeneratedColumn({ name: "CategoryID" })
    CategoryID: number

    @Column({
        type: "varchar",
        name: "CategoryName",
        length: 150,
        nullable: false,
    })
    CategoryName: string

    @Column({
        type: "text",
        name: "Description",
        nullable: true
    })
    Description?: string

    @Column({
        type: "bit",
        name: "IsActive",
        default: 1,
        nullable: true
    })
    IsActive?: number

    @Column({
        type: "date",
        name: "CreationDate",
        default: () => "SYSDATETIME()",
        nullable: true,
    })
    CreationDate?: string

    @OneToMany(() => Dish, (dish) => dish.Category)
    Dish: Dish
}