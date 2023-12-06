const URL = "http://localhost:3000/api/tables";


const getTables = async () => {
    try {
        const response = await axios.get(URL);
        return response.data;
    } catch (err) {
        console.log(err);
        alert("Ocurrio un error al obtener las mesas de la API")
    }
}

const addTable = async (data) => {
    try {
        const response = await axios.post(URL, data);
        alert("Mesa agregada correctamente");
        return response.data
    } catch (err) {
        alert("Ocurrio un error al agregar una mesa");
    }
}

const updateTable = async (data) => {
    try {
        console.log(data);
        const response = await axios.put(URL, data);
        console.log(response);
    } catch (err) {
        alert("Ocurrio un error al actualizar mesa");
    }
}

const deleteTable = async (data) => {
    try {
        const response = await axios.delete(`${URL}/${data.TableID}`);
    } catch (err) {
        alert("Ocurrio un error al eliminar mesa");
    }
}