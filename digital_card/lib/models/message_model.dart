import 'package:digital_card/models/employee_model.dart';

class Message {
  int messageID;
  String content;
  bool isActive;
  String creationDate;
  Employee employee;

  Message(this.messageID, this.content, this.isActive, this.creationDate,
      this.employee);
  factory Message.fromJson(Map<String, dynamic> json) {
    Employee employee = Employee.fromJson(json["Employee"]);
    return Message(json["MessageID"], json["Content"], json["IsActive"],
        json["CreationDate"], employee);
  }
}
