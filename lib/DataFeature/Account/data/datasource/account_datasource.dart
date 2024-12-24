import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../auth_manager.dart';
import '../../model/usermodel.dart';

//Interface for the authentication repository.
abstract class AuthenticationDataSource {
  Future<void> registerUser(String email, String userName, String password);

  Future<void> loginUser(String email, String password);

  Future<List<UserModel>> getDisplayUserInfo();
}

// Implementation of the authentication dataSourc.
final class AuthAccountDataSourceRemoot extends AuthenticationDataSource {
  Dio dio;
  // Constructor for data source for authentication-related operations.
  AuthAccountDataSourceRemoot(this.dio);
  // Implements the register method to handle user registration using the datasource
  @override
  Future<void> registerUser(
      String email, String userName, String password) async {
    try {
      var register = await dio.post('/auth/register', data: {
        'email': email,
        'username': userName,
        'first_name': userName,
        'last_name': userName,
        'password': password,
      });
      if (register.statusCode == 201) {
        await loginUser(email, password);
      }
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
        ex.response!.statusCode!,
        ex.response?.data['message'],
        response: ex.response,
      );
    } catch (ex) {
      // Handles unknown errors.
      throw ApiException(0, '.Please restart the application completely');
    }
  }

// Implements the login method to handle user login using the datasource
  @override
  Future<void> loginUser(String email, String password) async {
    try {
      var login = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (login.statusCode == 200) {
        // Saves user token, and displays a welcome notification.
        AuthManager().saveToken(login.data?['access_token']);

        return login.data?['access_token'];
      }
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
        ex.response!.statusCode!,
        ex.response?.data['message'],
        response: ex.response,
      );
    } catch (ex) {
      // Handles unknown errors.
      throw ApiException(0, '.Please restart the application completely');
    }
  }

// Fetches the user account information from the datasource
  @override
  Future<List<UserModel>> getDisplayUserInfo() async {
    try {
      var userInfo = await dio.get(
        '/user/',
        options: Options(
          headers: {'Authorization': 'Bearer ${AuthManager().getToken()}'},
        ),
      );
      return userInfo.data['data']
          .map<UserModel>((jsonObject) => UserModel.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
        ex.response!.statusCode!,
        ex.response?.data['message'],
        response: ex.response,
      );
    } catch (ex) {
      // Handles unknown errors.
      throw ApiException(0, ex.toString());
    }
  }
}
