import 'package:dio/dio.dart';

class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data;
    return ApiResponse(
      success: data['success'] ?? response.statusCode == 200,
      message: data['message'] ?? "Unknown error occurred.",
      data: data['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data,
  };
}