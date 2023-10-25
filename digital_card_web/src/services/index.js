let btn = document.querySelector("#btn");
let slidebar = document.querySelector(".slider-barra");
let overlay = document.querySelector(".overlay");
let dishContent = document.getElementById("dishes_content");
let isMenuActive = false;

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
    const popup = document.getElementById('popup');
    popup.style.display = 'block';
}

function closePopup() {
    const popup = document.getElementById('popup');
    popup.style.display = 'none';
}
let dishService = new DishesService();

const getDishs = async () => {
    const dishes = await dishService.getDishes();
    for (let dish of dishes) {
        let dishComponent = createDishComponent(dish)
        dishContent.innerHTML += dishComponent;
    }
}

function createDishComponent({ dishName, description, unitPrice, images }) {
    let verifyImage = images.length > 0 ? `http://13.58.243.181/${images[0].Path}` : "https://img.freepik.com/vector-premium/image-icon-vector-illustration-photo-on-isolated-background-gallery-sign-concept_993513-11.jpg";

    return `<div class="general-txt">
                <img src=${verifyImage} " alt="">
                    <h3>${dishName}</h3>
                    <p>${description ?? "Sin Descripcion"}</p>
                    <div class="prices">
                        <span>S/ ${unitPrice}</span>
                        <a href="#" class="btn-2" onclick="showPopup()">Editar</a>
                    </div>
            </div>`;
}

getDishs()


