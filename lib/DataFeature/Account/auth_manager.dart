import 'package:hive/hive.dart';
import 'package:flutter_landa_test/Hive/Account/authentication_hive.dart';

class AuthManager {
  // A AccountHive object to store user-related data
  AccountHive accountHive = AccountHive();

  // Reference to Hive box for user data
  late final Box<AccountHive> userLogin;

  AuthManager() {
    userLogin = Hive.box<AccountHive>('user_auth');
  }

  // Save the authentication token and update the login status
  void saveToken(String accessToken) {
    accountHive.token = accessToken;
    accountHive.isLogin = true;
    userLogin.put(1, accountHive);
  }

  // Retrieve the saved authentication token
  String getToken() {
    return userLogin.get(1)?.token ?? '';
  }

  // Save the user ID to the Hive box
  void saveId(int id) {
    accountHive.id = id.toString();
    userLogin.put(2, accountHive);
  }

  // Retrieve the saved user ID
  String getId() {
    return userLogin.get(2)?.id ?? '';
  }

  // Log out the user by clearing the token
  void logOut() {
    accountHive.token = null;
    userLogin.put(1, accountHive);
  }

  // Check if the user is logged in by verifying the token's existence
  bool isLogin() {
    return userLogin.get(1)?.token?.isNotEmpty ?? false;
  }
}
