var OrdersConteiner = document.getElementById("OrdersConteiner")
async function getOrders(){
    OrdersConteiner.innerHTML=""
    var response=await axios.get("https://n24kmjvt-3000.brs.devtunnels.ms/api/orders")
    var data = response.data 
    for(let order of data){
        var table = order["Table"]
        var orderItems = order["OrderItems"]
        OrdersConteiner.innerHTML+= createComponentOrder(table,order["IsComplete"],order["OrderID"])
        createComponentOrderItem(orderItems)  
    }
    console.log(response)
}
getOrders()

function createComponentOrder(Table,isComplete,orderid){
    return `<div class="Marco">
    <img src="../../imgs/Platillo1.jpg" alt="">
    <div class = "contenido">
            <div class = "titulo">${Table["TableName"]}</div>
            <div class = "listaO">Ordenes de la mesa</div>
            <div class = "listaO">Estado: ${isComplete?"completado":"progreso"}</div>
            <div id="OrdenesCL" class = "OrdenesCL">
            </div>
        <button onclick="setComplete(${orderid})" class="botn1">${isComplete?"progreso":"terminado"}</button>
        </div>
    </div>`
}
async function setComplete(orderid){
    await axios.put(`https://n24kmjvt-3000.brs.devtunnels.ms/api/orders/${orderid}`)
    getOrders()
}

function createComponentOrderItem(OrderItems){
    let OrdenesCL = document.getElementById("OrdenesCL")
    for(let OrderItem of OrderItems ){
        let Quantity = OrderItem["Quantity"]
        let Dish = OrderItem["Dish"]["DishName"]   
        OrdenesCL.innerHTML+=`- ${Dish}<span> X${Quantity}</span> <br>`
    }
}