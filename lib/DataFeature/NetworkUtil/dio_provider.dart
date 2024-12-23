import 'package:dio/dio.dart';
import 'package:flutter_landa_test/DataFeature/Account/auth_manager.dart';

class BaseUrl {
  // Define a static constant for the base URL of your API
  static const baseUrl = 'https://api.landagene.com/api';
}

class DioProvider {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager().getToken()}',
        },
      ),
    );
    return dio;
  }

  // Creates and configures a `Dio` instance without headers.
  // This can be used for requests that do not require authentication.
  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: BaseUrl.baseUrl,
    ));

    return dio;
  }
}
