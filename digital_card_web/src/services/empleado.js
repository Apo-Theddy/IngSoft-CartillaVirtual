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
    tablaBody = document.getElementById("databody")

async function loadEmployees() {
    const response = await axios.get("https://n24kmjvt-3000.brs.devtunnels.ms/api/employees")
    let reponsedata = response.data
    tablaBody.innerHTML = ''
    for (let employee of reponsedata) {
        tablaBody.innerHTML += createComponentDataBody(employee["EmployeeID"], employee["Dni"], employee["Names"], employee["Lastname"], employee["MotherLastname"], employee["DocumentType"], employee["CreationDate"], employee["IsActive"])
    }
    console.log(response);
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
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#readData">
             <i class="bi bi-eye"></i></button>
            <button class="btn btn-primary" onclick = "editInfo('${Names}','${Lastname}','${MotherLastname}','${Dni}','${DocumentType}','${CreationDate}')"><i class="bi bi-pencil"></i></button>
            <button class="btn btn-danger" onclick = "deleteInfo(${EmployeeID})"><i class="bi bi-trash"></i></button>
         </td>
          </tr>
    `
}


function readInfo(pic, name, dni, tip, sDate) {
    document.querySelector('.showImg').src = pic,
        document.querySelector('#showName').value = name,
        document.querySelector('#showDni').value = dni,
        document.querySelector('#ShowTwipo').value = tip,
        document.querySelector('#showsDate').value = sDate
}

async function editInfo(name,lastname,mothername,dni,tipo,creationdate) {
    isEdit = true
 

    submitBtn.innerText = "Update"

}

async function deleteInfo(EmployeeID) {
    if (confirm("Estas seguro que quieres eliminar?")) {
    await axios.delete(`https://n24kmjvt-3000.brs.devtunnels.ms/api/employees/${EmployeeID}`)  
        loadEmployees()
    }
}

form.addEventListener('submit', async (e) => {
    e.preventDefault()

    const information = {
        // employeeName: Username.value,
        // employeeDni: dni.value,
        // employeeTipo: tipo.value,
            "Dni": dni.value,
            "Names": Username.value,
            "Lastname": Lastname.value,
            "MotherLastname": Mothername.value,
            "DocumentType": tipo.value
    }

    submitBtn.innerText = "Submit"

    form.reset()

    await axios.post("https://n24kmjvt-3000.brs.devtunnels.ms/api/employees",information)
    loadEmployees()
})