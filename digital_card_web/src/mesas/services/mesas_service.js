const getTables = async () => {
    try {
        const response = await axios.get(`${apiurl}/tables`);
        return response.data;
    } catch (err) {
        console.log(err);
        alert("Ocurrio un error al obtener las mesas de la API")
    }
}

const addTable = async (data) => {
    try {
        const response = await axios.post(`${apiurl}/tables`, data);
        alert("Mesa agregada correctamente");
        return response.data
    } catch (err) {
        alert("Ocurrio un error al agregar una mesa");
    }
}

const updateTable = async (data) => {
    try {
        const response = await axios.put(`${apiurl}/tables`, data);
    } catch (err) {
        alert("Ocurrio un error al actualizar mesa");
    }
}