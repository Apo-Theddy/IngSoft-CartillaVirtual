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

file.onchange = function(){
    if(file.files[0].size < 1000000){
        var fileReader = new FileReader();

        fileReader.onload = function(e){
            imgUrl = e.target.result
            imgInput.src = imgUrl
        }
        fileReader.readAsDataURL(file.files[0])
    }else{
        alert("This file is too large!")
    }
}

form.addEventListener('submit' , (e)=> {
    e.preventDefault()

    const information = {
        picture: imgInput.src == undefined ? "../../imgs/logo.png" : imgInput.src,
        employeeName: Username.value,
        employeeDni: dni.value,
        employeeTipo: tipo.value,
        startDate: sDate.value
    }

    if(!isEdit){
        getData.push(information)
    }else{
        isEdit = false
        getData[editId] = information
    }

    localStorage.setItem('userProfile', JSON.stringify(getData))

    submitBtn.innerText = "Submit"
})