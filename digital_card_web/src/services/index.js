let btn = document.querySelector("#btn");
let slidebar = document.querySelector(".slider-barra");
let overlay = document.querySelector(".overlay");
let dishContent = document.getElementById("dishes_content");
let tableContent = document.getElementById("tables_content");
let isMenuActive = false;
let btnAddDish = document.getElementById("btnAddDish");
let divEditar = document.getElementById("divEditar");

btn.onclick = function () {
    slidebar.classList.toggle("active");
    overlay.classList.toggle("active");
    isMenuActive = !isMenuActive;
}

overlay.onclick = function () {
    if (isMenuActive) {
        slidebar.classList.remove("active");
        overlay.classList.remove("active");
        isMenuActive = false;
    }
}

btn.onclick = function () {
    slidebar.classList.toggle("active");
    overlay.classList.toggle("active");
    isMenuActive = !isMenuActive;
}

function showPopup() {
    const popup = document.getElementById('popup1');
    popup.style.display = 'block';
}


function closePopup() {
    const popup = document.getElementById('popup1');
    popup.style.display = 'none';
}

// function showEditPopUp(...data) {
//     const popup = document.getElementById('popup2');
//     popup.style.display = 'block';
//     divEditar.innerHTML = `
//      <div class="titulopop">Editar</div>
//                     <form action="">
//                         <p>
//                             <label for="NombrePlato">Platillo :</label>
//                             <input type="text" name="nombreplatillo" id="frmEditDishName" value='${data[0]}'>
//                         </p>
//                         <p>
//                             <label for="Preciop">Precio :</label>
//                             <input type="number" name="preciop" id="frmEditUnitPrice" min="0" value='${data[1]}' >
//                         </p>
//                         <p>
//                             <label for="cantidadp">Cantidad :</label>
//                             <input type="number" name="cantidadp" id="frmEditQuantityAvailable" min="0"  value='${data[2]}'>
//                         </p>
//                         <p>
//                             <label for="Categoriap">Cantegoria :</label>
//                             <input type="number" name="Categoriap" id="frmEditCategory" min="0"> 
//                         </p>
//                         <p class="block">
//                             <label for="Descripcionp">Descripción :</label>
//                             <textarea id="frmEditDescription" name="Descripcionp" rows="4"></textarea value='${data[3]}'>
//                         </p>
//                         <p class="block">
//                             <button type="editarb" id="btnEditButton">Editar</button>
//                         </p>
//                     </form>`

//     const btnEdit = document.getElementById("btnEditButton");
//     btnEdit.addEventListener("click", (event) => {
//         event.preventDefault();
//         const DishName = document.getElementById("frmEditDishName").value
//         const UnitPrice = parseFloat(document.getElementById("frmEditUnitPrice").value)
//         const QuantityAvailable = parseInt(document.getElementById("frmEditQuantityAvailable").value)
//         const Description = document.getElementById("frmEditDescription").value.trim();
//         data = { DishName, UnitPrice, QuantityAvailable, Description };
//         console.log(data);
//     })
// }


// function closePopup2() {
//     const popup = document.getElementById('popup2');
//     popup.style.display = 'none';
// }


// getDishes().then((dishes) => {
//     for (let i = 0; i < dishes.length; ++i) dishContent.innerHTML += createDishComponent(dishes[i])
// });

// btnAddDish.addEventListener("click", async (event) => {
//     event.preventDefault();
//     let DishName = document.getElementById("frmDishName").value
//     let UnitPrice = parseFloat(document.getElementById("frmUnitPrice").value)
//     let QuantityAvailable = parseInt(document.getElementById("frmQuantityAvailable").value)
//     let Description = document.getElementById("frmDescription").value.trim();
//     let data = { DishName, UnitPrice, QuantityAvailable, Description: Description === "" ? null : Description }
//     let dish = await addDish(data);
//     dishContent.innerHTML += createDishComponent(dish);
// })

// function createDishComponent(dish) {
//     let verifyImage = dish["Images"] !== undefined && dish["Images"].length > 0 ? `http://localhost:3000/${dish.images[0].Path}` : "https://img.freepik.com/vector-premium/image-icon-vector-illustration-photo-on-isolated-background-gallery-sign-concept_993513-11.jpg";
//     return `<div class="general-txt">
//                 <img src="${verifyImage}" alt="">
//                     <h3>${dish["DishName"]}</h3>
//                     <p>${dish["Description"] ?? "Sin Descripcion"}</p>
//                     <div class="prices">
//                         <span>S/ ${dish["UnitPrice"]}</span>
//                         <button class="btn-2" onclick="showEditPopUp('${dish["DishName"]}',${dish["UnitPrice"]},${dish["QuantityAvailable"]},${dish["Description"] === null ? "" : dish["Description"]})">Editar</button>
//                     </div>
//             </div>`;
// }

