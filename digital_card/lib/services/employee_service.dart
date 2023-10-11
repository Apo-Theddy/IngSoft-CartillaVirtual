import 'dart:convert';

import 'package:digital_card/constants/contants_vars.dart';
import 'package:digital_card/models/employee_model.dart';
import 'package:digital_card/models/util_model.dart';
import "package:http/http.dart" as http;

class EmployeeService extends UtilModel {
  Future<Employee?> getEmployee(String dni) async {
    try {
      http.Response response = await http.get(uri("employees/$dni"));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return Employee.fromJson(jsonData);
      }
    } catch (err) {
      handleError("Error al obener el empleado", err);
    }

    return null;
  }
}
