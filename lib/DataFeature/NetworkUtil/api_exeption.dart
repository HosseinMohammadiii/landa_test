import 'package:dio/dio.dart';

// Custom exception class for handling API errors
class ApiException implements Exception {
  int code;
  String? message;
  Response<dynamic>? response;

  // Constructor to initialize the exception with the code, message, and optional response
  ApiException(this.code, this.message, {this.response}) {
    // Custom error messages for a specific HTTP status code
    if (code == 400) {
      message = 'داده‌های نادرست یا اعتبارسنجی ناموفق بود.';
    }
    if (code == 403) {
      message = 'رمز عبور نادرست یا اعتبارنامه ناقص.';
    }
    if (code == 404) {
      message = 'ایمیل با هیچ حسابی مطابقت ندارد.';
    }
  }
}
