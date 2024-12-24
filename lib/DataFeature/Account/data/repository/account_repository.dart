import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../model/usermodel.dart';
import '../datasource/account_datasource.dart';

//Interface for the authentication repository.
abstract class AuthAccountRepository {
  Future<Either<String, String>> registerUser(
      String email, String userName, String password);

  Future<Either<String, String>> loginUser(String email, String password);

  Future<Either<String, List<UserModel>>> getDisplayUserInfo();
}

// Implementation of the authentication repository.
final class AuthAccountRepositoryRemoot extends AuthAccountRepository {
  final AuthenticationDataSource authAccount;
  // Constructor for repository for authentication-related operations.
  AuthAccountRepositoryRemoot(this.authAccount);
  // Implements the register method to handle user registration using the repository
  @override
  Future<Either<String, String>> registerUser(
      String email, String userName, String password) async {
    try {
      await authAccount.registerUser(email, userName, password);
      return right('ثبت نام انجام شد!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

// Implements the login method to handle user login using the repository
  @override
  Future<Either<String, String>> loginUser(
      String email, String password) async {
    try {
      await authAccount.loginUser(email, password);
      return right('ورود انجام شد!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

// Fetches the user account information from the repository
  @override
  Future<Either<String, List<UserModel>>> getDisplayUserInfo() async {
    try {
      var userInfo = await authAccount.getDisplayUserInfo();
      return right(userInfo);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
