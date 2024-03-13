import 'dart:convert';

class ApiError {
  final String? code, message;

  ApiError(this.code, this.message);

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      json["code"],
      json["message"],
    );
  }

  @override
  String toString() {
    return jsonEncode({
      "code": code,
      "message": message,
    });
  }
}
