/* AQUI TRABAJO
ME PUEDO ORIENTAR DE PLATILLO PQ ES IGUAL LO MISMO DIIIIICE 
AGREGAR NUEVA MESA
EDITAR NUEVA MESA
ELIMINAR NUEVA MESA
*/

var botonAgregar = document.getElementById("botonAgregar");
var botonEliminar = document.querySelectorAll('.boton-eliminar');
var botonEditar = document.querySelectorAll('.boton-editar');
var form = document.getElementById("formMesa");


/*  CARGA MESASS */
async function cargaMesas() {
    const response = await axios.get("http://localhost:3000/api/tables")
    let reponsedata = response.data;
    let container_2 = document.getElementById("container2");


    container_2.innerHTML = ''
    for (let table of reponsedata) {
        container_2.innerHTML += `<div class="general-txt">
                        <img src="../../imgs/Mesa.jpeg" alt="">
                        <h3>${table.TableName}</h3>
                        <p>Mesa...</p>
                        <button type="button" onclick="handleClick(this)" class="btn-2 boton-eliminar" data-id="${table.TableID}">Eliminar</button>
                        <button type="button" onclick="handleEditar(this)" class="btn-2 boton-editar" data-id="${table.TableID}">Editar</button>
                    </div>`;
    }
}

cargaMesas();


/* AGREGAR */
botonAgregar.addEventListener('click', async (e) => {
    e.preventDefault();
    alertify.prompt('Agregar mesa nueva', 'Ingrese nombre de mesa', ''
        , function (evt, value) {
            const information = { "TableName": value, }
            addTable(information);
            alertify.success('Mesa Agregada correctamente: ' + value)
            location.reload()
        }
        , function () { alertify.error('Cancelado, no se agregó nada') });
})

/* ELIMINAR */
//botonEliminar.addEventListener('click', async (e) => {
//   e.preventDefault();
//})

// Obtén todos los elementos con la clase "boton"

// Función para manejar el clic
async function handleClick(boton) {

    alertify.confirm("¿Seguro que desea eliminar?", function (e) {
        if (e) {
            // Obtén el valor del atributo data-id
            const idMesa = boton.getAttribute('data-id');
            const information = { "TableID": idMesa, }
            deleteTable(information);
            location.reload()
        }
    });
}
// Función para manejar el clic
async function handleEditar(boton) {
    alertify.prompt('Editar Mesa', 'Ingrese nuevo nombre de mesa', ''
        , function (evt, value) {
            const idMesa = Number(boton.getAttribute('data-id'));
            const information = { "TableName": value, "TableID": idMesa }
            updateTable(information);
            alertify.success('Mesa editada correctamente')
            //location.reload()
        }
        , function () { alertify.error('Cancelado, no se editó nada') });
}




/* EDITAR */
/*
botonEditar.addEventListener("click", async (e) => {

    let nombreMesa = document.getElementById("nombreMesa").value;
    let id = document.getElementById("nombreMesa").value;


    const information = {
        "TableName": nombreMesa,
        "TableID": nombreMesa,
    }
    await axios.put(`https://n24kmjvt-3000.brs.devtunnels.ms/api/employees`, information)
    loadEmployees()
})*/