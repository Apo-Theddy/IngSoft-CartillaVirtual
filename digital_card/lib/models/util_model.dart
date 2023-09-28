class UtilModel {
  Exception handleError(String message, dynamic error) {
    final errorDetails = "$message: $error";
    print(errorDetails);
    return throw Exception(errorDetails);
  }

  Uri uri(String path) {
    return Uri.parse("http://localhost:3000/api/$path");
  }
}
