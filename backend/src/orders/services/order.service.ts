import { Injectable, NotFoundException } from "@nestjs/common";
import { Order, OrderItem } from "../entities/order.entity";
import { InjectRepository } from "@nestjs/typeorm"
import { Repository } from "typeorm"
import { CreateOrderDto } from "../dtos/create-order.dto";
import { TableService } from "src/tables/services/table.service";
import { UpdateOrderDto } from "../dtos/update-order.dto";
import { DishService } from "src/dishes/services/dish.service";
import { OrderDish } from "../interfaces/order.interface";

@Injectable()
export class OrderService {
    constructor(
        @InjectRepository(Order) private orderRepository: Repository<Order>,
        @InjectRepository(OrderItem) private orderItemRepository: Repository<OrderItem>,
        private readonly tableService: TableService,
        private readonly dishService: DishService
    ) { }


    async GetOrders() {
        let orders = await this.orderRepository.find({ where: { IsActive: 1 } })
        return orders
    }

    async GetOrder(id: number): Promise<Order> {
        let order = this.orderRepository.findOne({ where: { IsActive: 1 } })
        if (!order)
            throw new NotFoundException(`No se encontro ninguna orden con el id: '${id}'`)
        return order
    }

    async GetOrdersByTable(tableID: number): Promise<Order> {
        let order = await this.orderRepository.findOne({ where: { Table: { TableID: tableID }, IsActive: 1, IsComplete: 0 } })
        if (!order) throw new NotFoundException("No se encontro ordenes para esta mesa");
        return order;
    }

    async VerifyOrder(tableID: number, orderDishes: OrderDish[]): Promise<Order> {
        let order = await this.orderRepository.findOne({ where: { Table: { TableID: tableID }, IsComplete: 0 } })
        if (!order) {
            let table = await this.tableService.GetTable(tableID)
            let availableDishes = []
            let newOrder = this.orderRepository.create({ Table: table })
            for (let orderDish of orderDishes) {
                let orderItem = await this.validateOrderItem(orderDish.DishID, orderDish.Quantity)
                availableDishes.push(orderItem)
                newOrder.OrderItems = availableDishes
            }
            return newOrder
        }
        else {
            for (let orderDish of orderDishes) {
                let orderItem = await this.validateOrderItem(orderDish.DishID, orderDish.Quantity)
                order.OrderItems.push(orderItem)
            }
            return order
        }
    }

    async validateOrderItem(dishID: number, quantity: number): Promise<OrderItem> {
        let dish = await this.dishService.GetDish(dishID)
        if (dish != null) {
            let newOrderItem = this.orderItemRepository.create({ Dish: dish, Quantity: quantity })
            await Promise.all([
                this.dishService.ConsumeDishByQuantity(dishID, quantity),
                this.orderItemRepository.save(newOrderItem)
            ])
            return newOrderItem;
        }
    }

    async AddOrder(createOrderDto: CreateOrderDto): Promise<Order> {
        let order = await this.VerifyOrder(createOrderDto.TableID, createOrderDto.OrderDishes);
        return await this.orderRepository.save(order)
    }

    async AddDishToOrder({ OrderID, DishID, Quantity }: UpdateOrderDto) {
        let [order, dish] = await Promise.all([
            this.GetOrder(OrderID),
            this.dishService.ConsumeDishByQuantity(DishID, Quantity),
        ])
        if (dish !== null) {
            let newOrderItem = this.orderItemRepository.create({
                Dish: dish,
                Quantity,
            })
            order.OrderItems.push(newOrderItem)
            await Promise.all([
                this.orderRepository.save(order),
                this.orderItemRepository.save(newOrderItem)
            ])
        }
    }

    async SetOrderComplete(id: number) {
        let order = await this.GetOrder(id)
        order.IsComplete = 1
        await this.orderRepository.save(order)
    }

    async GetOrderItem(id: number): Promise<OrderItem> {
        let orderItem = await this.orderItemRepository.findOne({ where: { OrderItemID: id } })
        if (!id)
            throw new NotFoundException(`No se encontro el item con el id: '${id}'`)
        return orderItem
    }

    async RemoveDishToOrder(id: number) {
        let orderItem = await this.GetOrderItem(id)
        await this.orderItemRepository.delete(orderItem)
    }

    async RemoveOrder(id: number) {
        let order = await this.GetOrder(id)
        order.IsActive = 0
        await this.orderRepository.save(order)
    }

}