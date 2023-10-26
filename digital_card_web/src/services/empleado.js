var form = document.getElementById("myForm"),
    imgInput = document.querySelector(".img"),
    file = document.getElementById("imgInput"),
    Username = document.getElementById("name"),
    dni = document.getElementById("dni"),
    tipo = document.getElementById("tipo"),
    sDate = document.getElementById("sDate"),
    submitBtn = document.querySelector(".submit"),
    userInfo = document.getElementById("data")

let getData = localStorage.getItem('userProfile') ? JSON.parse(localStorage.getItem("userProfile")) : []

let isEdit = false, editId
showInfo()

file.onchange = function () {
    if (file.files[0].size < 1000000) {
        var fileReader = new FileReader();

        fileReader.onload = function (e) {
            imgUrl = e.target.result
            imgInput.src = imgUrl
        }
        fileReader.readAsDataURL(file.files[0])
    } else {
        alert("El archivo es demasiado grande!")
    }
}

function showInfo() {
    document.querySelectorAll('.employeeDetails').forEach(info => info.remove())
    getData.forEach((element, index) => {
        let createElement = `<tr class="employeeDetails">
            <td>${index + 1}</td>
            <td><img src="${element.picture}" alt="" width="50" height="50"</td>
            <td>${element.employeeName}</td>
            <td>${element.employeeDni}</td>
            <td>${element.employeeTipo}</td>
            <td>${element.startDate}</td>

            <td>
                <button class="btn btn-success" onclick="readInfo('${element.picture}','${element.employeeName}',
                    '${element.employeeDni}','${element.employeeTipo}','${element.startDate}') 
                    data-bs-toggle="modal" data-bs-target="#readData"><i class="bi bi-eye"></i></button>

                <button class="btn btn-primary"onclick="editInfo(${index},'${element.picture}','${element.employeeName}',
                '${element.employeeDni}','${element.employeeTipo}','${element.startDate}') "data-bs-toggle="modal" data-bs-target="#userForm">
                <i class="bi bi-pencil"></i></button>

                <button class="btn btn-danger" onclick ="deleteInfo(${index})"><i class="bi bi-trash"></i></button>
            </td>

        </tr>`

        userInfo.innerHTML += createElement
    })
}
showInfo()

function readInfo(pic,name,dni,tip,sDate){
    document.querySelector('.showImg').src = pic,
    document.querySelector('#showName').value = name,
    document.querySelector('#showDni').value = dni,
    document.querySelector('#ShowTipo').value = tip,
    document.querySelector('#showsDate').value = sDate
}

function editInfo(pic,name,dni,tip,sDate){
    isEdit = true
    editId = index
    imgInput.src = pic
    Username.value=name
    dni.value = dni
    tipo.value = tip
    sDate.value = sDate

    submitBtn.innerText = "Update"
    modalTitle.innerText = "Cambiar datos"
}

function deleteInfo(index){
    if(confirm("Estas seguro que quieres eliminar?")){
        getData.splice(index,1)
        localStorage.setItem("userProfile", JSON.stringify(getData))
        showInfo()
    }
}

form.addEventListener('submit', (e) => {
    e.preventDefault()

    const information = {
        picture: imgInput.src == undefined ? "../../imgs/logo.png" : imgInput.src,
        employeeName: Username.value,
        employeeDni: dni.value,
        employeeTipo: tipo.value,
        startDate: sDate.value
    }

    if (!isEdit) {
        getData.push(information)
    } else {
        isEdit = false
        getData[editId] = information
    }

    localStorage.setItem('userProfile', JSON.stringify(getData))

    submitBtn.innerText = "Submit"
    modalTitle.innerHtml = "Fill The Form"

    showInfo()

    form.reset()

    imgInput.src = "../../imgs/logo.png"
    modal.style.display = "none"
    document.querySelector(".modal-backdrop").remove()
})