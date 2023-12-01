const URL = "http://localhost:3000/api/dishs";


const getDishes = async () => {
    try {
        const response = await axios.get(URL);
        return response.data;
    } catch (err) {
        console.log(err);
        alert("Ocurrio un error al obtener los platillos de la API")
    }
}

const addDish = async (data) => {
    try {
        const response = await axios.post(URL, data);
        alert("Platillo agregado correctamente");
        return response.data
    } catch (err) {
        alert("Ocurrio un error al agregar un platillo");
    }
}

const updateDish = async (data) => {
    try {
        const response = await axios.put(URL, data);
    } catch (err) {
        alert("Ocurrio un error al actualizar el platillo");
    }
}