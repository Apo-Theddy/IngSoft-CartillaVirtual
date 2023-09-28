import { Dish } from "src/dishes/entities/dish.entity"
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn, OneToMany } from "typeorm"


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

    @OneToMany(() => Dish, (dish) => dish.Categories, { nullable: true })
    @JoinColumn({ name: "DishID" })
    Dish?: Dish
}