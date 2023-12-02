/* AQUI TRABAJO
ME PUEDO ORIENTAR DE PLATILLO PQ ES IGUAL LO MISMO DIIIIICE 
AGREGAR NUEVA MESA
EDITAR NUEVA MESA
ELIMINAR NUEVA MESA
*/


var form = document.getElementById("btnAgregar");



form.addEventListener('click', async (e) => {
    e.preventDefault();
    let nombreMesa = document.getElementById("nombreMesa").value;

    console.log(nombreMesa);

    //let information = { nombreMesa }
    addTable(nombreMesa);


    /*
        //await axios.post("https://n24kmjvt-3000.brs.devtunnels.ms/api/tables", information)
        await axios.post("http://localhost:3000/api/tables", information)
    */
})