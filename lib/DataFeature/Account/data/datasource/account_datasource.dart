import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../auth_manager.dart';
import '../../model/usermodel.dart';

//Interface for the authentication repository.
abstract class AuthenticationDataSource {
  // Registers a new user with a username and password.
  Future<void> registerUser(String email, String userName, String password);
  // Logs in a user and returns a token.
  Future<void> loginUser(String email, String password);

  // Fetches and returns account information of the current user.
  Future<List<UserModel>> getDisplayUserInfo();
}

final class AuthAccountDataSourceRemoot extends AuthenticationDataSource {
  Dio dio;
  AuthAccountDataSourceRemoot(this.dio);
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
        AuthManager().saveId(login.data['user']['id']);

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
