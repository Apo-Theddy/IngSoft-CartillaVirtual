class TableService {
    constructor() {
        this.url = "http://localhost:3000/api/tables";
    }

    async getTables() {
        let tables = []
        try {
            const response = await axios(this.url);
            tables = response.data.map((table) => Table.fromJson(table))
        } catch (err) {
            console.log(`Ocurrio un error: ${err}`)
        }
        return tables;
    }
}                                                                                           