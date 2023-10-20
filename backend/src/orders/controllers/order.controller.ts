import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from "@nestjs/common";
import { Order, OrderItem } from "../entities/order.entity";
import { OrderService } from "../services/order.service";
import { CreateOrderDto } from "../dtos/create-order.dto";
import { UpdateOrderDto } from "../dtos/update-order.dto";
import { ApiOperation, ApiTags } from "@nestjs/swagger";

@Controller("orders")
@ApiTags("Orders")
export class OrderController {
    constructor(private readonly orderService: OrderService) { }

    @Get()
    @ApiOperation({
        summary: "Get all orders"
    })
    GetOrders(): Promise<Order[]> {
        return this.orderService.GetOrders()
    }

    @Get(":id")
    @ApiOperation({
        summary: "Get order by id"
    })
    GetOrder(@Param("id", ParseIntPipe) id: number): Promise<Order> {
        return this.orderService.GetOrder({ where: { OrderID: id, IsComplete: 0 } })
    }

    @Get("table/:id")
    @ApiOperation({
        summary: "Get order by table id"
    })
    GetOrdersByTable(@Param("id", ParseIntPipe) id: number): Promise<Order> {
        return this.orderService.GetOrdersByTable(id);
    }

    @Get("item/:id")
    @ApiOperation({
        summary: "Get dish from order",
        description: "Get a dish by your id regarding the order"
    })
    GetOrderItem(@Param("id", ParseIntPipe) id: number): Promise<OrderItem> {
        return this.orderService.GetOrderItem(id)
    }

    @Post()
    @ApiOperation({
        summary: "Add new order"
    })
    AddOrder(@Body() createOrderDto: CreateOrderDto): Promise<Order> {
        return this.orderService.AddOrder(createOrderDto)
    }

    @Put(":id")
    @ApiOperation({
        summary: "Set as full order"
    })
    SetOrderComplete(@Param("id", ParseIntPipe) id: number) {
        return this.orderService.SetOrderComplete(id)
    }

    @Put()
    @ApiOperation({
        summary: "Add a new dish to the order"
    })
    AddDishToOrder(@Body() updateOrderDto: UpdateOrderDto) {
        this.orderService.AddDishToOrder(updateOrderDto)
    }

    @Delete(":id")
    @ApiOperation({
        summary: "Delete order",
        description: "Delete order by Id"
    })
    RemoveOrder(@Param("id", ParseIntPipe) id: number) {
        this.orderService.RemoveOrder(id)
    }

    @Delete("item/:id")
    @ApiOperation({
        summary: "Delete dish from order",
        description: "Delete a dish from order by its id"
    })
    RemoveDishToOrder(@Param("id", ParseIntPipe) id: number) {
        this.orderService.RemoveDishToOrder(id)
    }

}