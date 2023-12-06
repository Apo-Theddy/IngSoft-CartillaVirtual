const getDishes = async () => {
    try {
        const response = await axios.get(`${apiurl}/dishs`);
        return response.data;
    } catch (err) {
        console.log(err);
        alert("Ocurrio un error al obtener los platillos de la API")
    }
}

const addDish = async (data) => {
    try {
        const response = await axios.post(`${apiurl}/dishs`, data);
        alert("Platillo agregado correctamente");
        return response.data
    } catch (err) {
        alert("Ocurrio un error al agregar un platillo");
    }
}

const updateDish = async (data) => {
    try {
        const response = await axios.put(`${apiurl}/dishs`, data);
        alert("Platillo actualizado");
    } catch (err) {
        alert("Ocurrio un error al actualizar el platillo");
    }
}