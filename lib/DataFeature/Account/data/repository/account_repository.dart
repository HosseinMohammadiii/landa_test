import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../model/usermodel.dart';
import '../datasource/account_datasource.dart';

abstract class AuthAccountRepository {
  Future<Either<String, String>> registerUser(
      String email, String userName, String password);
  Future<Either<String, String>> loginUser(String email, String password);

  Future<Either<String, List<UserModel>>> getDisplayUserInfo();
}

final class AuthAccountRepositoryRemoot extends AuthAccountRepository {
  final AuthenticationDataSource authAccount;
  AuthAccountRepositoryRemoot(this.authAccount);
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
