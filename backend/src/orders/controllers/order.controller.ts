import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from "@nestjs/common";
import { Order, OrderItem } from "../entities/order.entity";
import { OrderService } from "../services/order.service";
import { CreateOrderDto } from "../dtos/create-order.dto";
import { UpdateOrderDto } from "../dtos/update-order.dto";

@Controller("orders")
export class OrderController {
    constructor(private readonly orderService: OrderService) { }

    @Get()
    GetOrders() {
        return this.orderService.GetOrders()
    }

    @Get(":id")
    GetOrder(@Param("id", ParseIntPipe) id: number): Promise<Order> {
        return this.orderService.GetOrder({ where: { OrderID: id, IsComplete: 0 } })
    }

    @Get("table/:id")
    GetOrdersByTable(@Param("id", ParseIntPipe) id: number): Promise<Order> {
        return this.orderService.GetOrdersByTable(id);
    }

    @Get("item/:id")
    GetOrderItem(@Param("id", ParseIntPipe) id: number): Promise<OrderItem> {
        return this.orderService.GetOrderItem(id)
    }

    @Post()
    AddOrder(@Body() createOrderDto: CreateOrderDto): Promise<Order> {
        return this.orderService.AddOrder(createOrderDto)
    }

    @Put(":id")
    SetOrderComplete(@Param("id", ParseIntPipe) id: number) {
        return this.orderService.SetOrderComplete(id)
    }

    @Put()
    AddDishToOrder(@Body() updateOrderDto: UpdateOrderDto) {
        this.orderService.AddDishToOrder(updateOrderDto)
    }

    @Delete(":id")
    RemoveOrder(@Param("id", ParseIntPipe) id: number) {
        this.orderService.RemoveOrder(id)
    }

    @Delete("item/:id")
    RemoveDishToOrder(@Param("id", ParseIntPipe) id: number) {
        this.orderService.RemoveDishToOrder(id)
    }

}