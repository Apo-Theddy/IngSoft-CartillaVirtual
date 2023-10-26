import "package:digital_card_desktop/constants/contants_vars.dart";

class UtilModel {
  Exception handleError(String message, dynamic error) {
    final errorDetails = "$message: $error";
    print(errorDetails);
    throw Exception(errorDetails);
  }

  Uri uri(String path) {
    return Uri.parse("$url/api/$path");
  }
}
