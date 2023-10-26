class Employee {
  int employeeID;
  String dni;
  String names;
  String lastname;
  String motherLastname;
  String documentType;
  String creationDate;
  bool isActive;

  Employee(this.employeeID, this.dni, this.names, this.lastname,
      this.motherLastname, this.documentType, this.creationDate, this.isActive);

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        json["EmployeeID"],
        json["Dni"],
        json["Names"],
        json["Lastname"],
        json["MotherLastname"],
        json["DocumentType"],
        json["CreationDate"],
        json["IsActive"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "EmployeeID": employeeID,
      "Dni": dni,
      "Names": names,
      "Lastname": lastname,
      "MotherLastname": motherLastname,
      "DocumentType": documentType,
      "CreationDate": creationDate,
      "IsActive": isActive
    };
  }
}
