class TableModel {
  int tableID;
  String tableName;
  String? creationDate;
  bool? isActive;
  TableModel(this.tableID, this.tableName, this.creationDate, this.isActive);

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(json["TableID"], json["TableName"], json["CreationDate"],
        json["IsActive"]);
  }
}
