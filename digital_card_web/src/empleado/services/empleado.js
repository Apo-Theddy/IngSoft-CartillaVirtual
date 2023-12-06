var form = document.getElementById("myForm"),
    imgInput = document.querySelector(".img"),
    file = document.getElementById("imgInput"),
    Username = document.getElementById("name"),
    Lastname = document.getElementById("Lastname"),
    Mothername = document.getElementById("Mothername"),
    dni = document.getElementById("dni"),
    tipo = document.getElementById("tipo"),
    sDate = document.getElementById("sDate"),
    submitBtn = document.querySelector(".submit"),
    userInfo = document.getElementById("data"),
    tablaBody = document.getElementById("databody"),
    showName = document.getElementById("showName"),
    showLastname = document.getElementById("showLastname"),
    showMothername = document.getElementById("showMothername"),
    showDni = document.getElementById("showDni"),
    showTipo = document.getElementById("showTipo"),
    showDate = document.getElementById("showDate"),
    btnEditarEmpleado = document.getElementById("btnEditarEmpleado")

async function loadEmployees() {
    const response = await axios.get(`${apiurl}/employees`)
    let reponsedata = response.data
    tablaBody.innerHTML = ''
    for (let employee of reponsedata) {
        tablaBody.innerHTML += createComponentDataBody(employee["EmployeeID"], employee["Dni"], employee["Names"], employee["Lastname"], employee["MotherLastname"], employee["DocumentType"], employee["CreationDate"], employee["IsActive"])
    }
}

loadEmployees()

function createComponentDataBody(EmployeeID, Dni, Names, Lastname, MotherLastname, DocumentType, CreationDate, IsActive) {
    return `
    <tr>
        <td>${EmployeeID}</td>
        <td>${Names} ${Lastname} ${MotherLastname}</td>
        <td>${Dni}</td>
        <td>${DocumentType}</td>
        <td>${IsActive}</td>
        <td>${CreationDate}</td>
        <td>
            <button class="btn btn-success" onclick = "readInfo('${Names}','${Lastname}','${MotherLastname}','${Dni}','${DocumentType}','${CreationDate}')" data-bs-toggle="modal" data-bs-target="#readData">
             <i class="bi bi-pencil"></i></button>
            <button class="btn btn-danger" onclick = "deleteInfo(${EmployeeID})"><i class="bi bi-trash"></i></button>
         </td>
          </tr>
    `
}

function readInfo(name, lastname, mothername, dni, tipo, creationdate) {
    showName.value = name
    showLastname.value = lastname
    showMothername.value = mothername
    showDni.value = dni
    showTipo.value = tipo
    showDate.value = creationdate

}

btnEditarEmpleado.addEventListener("click", async (e) => {
    const information = {
        "Dni": showDni.value,
        "Names": showName.value,
        "Lastname": showLastname.value,
        "MotherLastname": showMothername.value,
        "DocumentType": showTipo.value
    }
    await axios.put(`${apiurl}/employees`, information)
    loadEmployees()
})

async function deleteInfo(EmployeeID) {
    if (confirm("Estas seguro que quieres eliminar?")) {
        await axios.delete(`${apiurl}/employees/${EmployeeID}`)
        loadEmployees()
    }
}

form.addEventListener('submit', async (e) => {
    e.preventDefault()
    const information = {
        "Dni": dni.value,
        "Names": Username.value,
        "Lastname": Lastname.value,
        "MotherLastname": Mothername.value,
        "DocumentType": tipo.value
    }
    form.reset()
    await axios.post(`${apiurl}/employees`, information)

    loadEmployees()
})