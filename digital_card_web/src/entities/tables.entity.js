class Table {
    constructor(tableID, tableName, creationDate, isActive, images) {
        this.tableID = tableID;
        this.tableName = tableName;
        this.creationDate = creationDate
        this.isActive = isActive
        this.images = images

    }

    static fromJson(json) {
        return new Table(
            json["tableID"],
            json["tableName"],
            json["creationDate"],
            json["IsActive"],
            json["Images"]);
    }
}