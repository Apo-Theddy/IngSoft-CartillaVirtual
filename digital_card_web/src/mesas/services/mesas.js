/* AQUI TRABAJO
ME PUEDO ORIENTAR DE PLATILLO PQ ES IGUAL LO MISMO DIIIIICE 
AGREGAR NUEVA MESA
EDITAR NUEVA MESA
ELIMINAR NUEVA MESA
*/

var botonAgregar = document.getElementById("btnAgregar");
var botonEditar = document.getElementById("botonEditar");
var botonEliminar = document.getElementById("botonEliminar");
var form = document.getElementById("formMesa");


/*  CARGA MESAS */
async function cargaMesas() {
    const response = await axios.get(`${apiurl}/tables`)
    let reponsedata = response.data;
    let container_2 = document.getElementById("container2");


    container_2.innerHTML = ''
    for (let table of reponsedata) {
        console.log(table);
        container_2.innerHTML += `<div class="general-txt">
                        <img src="../../imgs/Mesa.jpeg" alt="">
                        <h3>${table.TableName}</h3>
                        <p>Mesa...</p>
                        <button href="#" class="btn-2" onclick="showPopup2('popup2')" id="BotonEliminar" data-id="${table.TableID}">Eliminar</button>
                        <button href="#" class="btn-2" onclick="showPopup2('popup2')" id="botonEditar" data-id="${table.TableID}">Editar</button>
                    </div>`;
    }
}

cargaMesas();


/* AGREGAR */
botonAgregar.addEventListener('click', async (e) => {
    e.preventDefault();
    let nombreMesa = document.getElementById("nombreMesa").value;

    const information = { "TableName": nombreMesa, }
    addTable(information);

    form.reset();
})

/* EDITAR */
botonEditar.addEventListener("click", async (e) => {

    let nombreMesa = document.getElementById("nombreMesa").value;
    let id = document.getElementById("nombreMesa").value;


    const information = {
        "TableName": nombreMesa,
        "TableID": nombreMesa,
    }
    await axios.put(`${apiurl}/tables`, information)
    cargaMesas()
})
