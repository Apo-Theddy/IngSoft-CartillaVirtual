import { Dish } from "src/dishes/entities/dish.entity";
import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";

@Entity({ name: "Images" })
export class Image {
    @PrimaryGeneratedColumn({ name: "ImageID" })
    ImageID: number


    @Column({
        type: "varchar",
        name: "Path",
        nullable: true
    })
    Path?: string

    @Column({
        type: "varchar",
        name: "OriginalName",
        nullable: true,
    })
    OriginalName?: string

    @Column({
        type: "varchar",
        name: "UniqueName",
        nullable: true
    })
    UniqueName?: string

    @Column({
        type: "date",
        name: "CreationDate",
        nullable: true,
        default: () => "SYSDATETIME()"
    })
    CreationDate?: string


    @Column({
        type: "bit",
        name: "IsActive",
        nullable: true,
        default: 1
    })
    IsActive?: number

    @ManyToOne(() => Dish)
    @JoinColumn({ name: "DishID" })
    Dish: Dish
}