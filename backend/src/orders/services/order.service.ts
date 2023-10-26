import { Injectable, NotFoundException } from "@nestjs/common";
import { Order, OrderItem } from "../entities/order.entity";
import { InjectRepository } from "@nestjs/typeorm"
import { FindOneOptions, Repository } from "typeorm"
import { CreateOrderDto } from "../dtos/create-order.dto";
import { TableService } from "src/tables/services/table.service";
import { UpdateOrderDto } from "../dtos/update-order.dto";
import { DishService } from "src/dishes/services/dish.service";
import { OrderDish } from "../interfaces/order.interface";
import { EmployeeService } from "src/employees/service/employees.service";

@Injectable()
export class OrderService {

    constructor(
        @InjectRepository(Order) private orderRepository: Repository<Order>,
        @InjectRepository(OrderItem) private orderItemRepository: Repository<OrderItem>,
        private readonly tableService: TableService,
        private readonly dishService: DishService,
        private readonly employeeService: EmployeeService
    ) { }


    async GetOrders() {
        let orders = await this.orderRepository.find({ where: { IsActive: 1 } })
        return orders
    }

    async GetOrder(options: FindOneOptions<Order>): Promise<Order> {
        let order: Order = await this.orderRepository.findOne(options);
        if (!order)
            throw new NotFoundException(`No se encontro ninguna orden con el id: '${options.order.OrderID}'`)
        return order
    }

    async GetOrdersByTable(tableID: number): Promise<Order> {
        let order = await this.orderRepository.findOne({ where: { Table: { TableID: tableID }, IsActive: 1, IsComplete: 0 } })
        if (!order) throw new NotFoundException("No se encontro ordenes para esta mesa");
        return order;
    }

    async VerifyOrder(tableID: number, orderDishes: OrderDish[], employeeID: number): Promise<Order> {
        let order = await this.orderRepository.findOne({ where: { IsComplete: 0, Table: { TableID: tableID } } })
        if (order === null) {
            let [table, employee] = await Promise.all([
                this.tableService.GetTable(tableID),
                this.employeeService.GetEmployeeById(employeeID)
            ]);
            let availableDishes = []
            let newOrder = this.orderRepository.create({ Table: table, Employee: employee })
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
        let order = await this.VerifyOrder(createOrderDto.TableID, createOrderDto.OrderDishes, createOrderDto.EmployeeID);
        return await this.orderRepository.save(order)
    }

    async AddDishToOrder({ OrderID, DishID, Quantity }: UpdateOrderDto) {
        let [order, dish] = await Promise.all([
            this.GetOrder({ where: { OrderID, IsComplete: 0 } }),
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

    async SetOrderComplete(OrderID: number) {
        let order = await this.GetOrder({ where: { OrderID } })
        if (order.IsComplete) order.IsComplete = 0;
        else order.IsComplete = 1
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

    async RemoveOrder(OrderID: number) {
        let order = await this.GetOrder({ where: { OrderID, IsComplete: 0 } })
        order.IsActive = 0
        await this.orderRepository.save(order)
    }

}