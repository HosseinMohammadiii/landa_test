import 'package:dartz/dartz.dart';
import 'package:flutter_landa_test/DataFeature/Account/model/usermodel.dart';

abstract class AccountState {}

//The initial state of the authentication process
final class AuthInitiateState extends AccountState {}

//Represents the loading state during the authentication process.
final class AccountLoadingState extends AccountState {}

//Represents the loading state during the user information process.
final class UserInfoLoadingState extends AccountState {}

//Represents the error state during the authentication process.
final class AccountErrorState extends AccountState {}

//Represents the response state after the authentication process.
final class AuthResponseState extends AccountState {
  Either<String, String> response;
  AuthResponseState(this.response);
}

//Represents the response state after the user information process.
final class UserInfoResponseState extends AccountState {
  Either<String, List<UserModel>> displayUserInfo;
  UserInfoResponseState(this.displayUserInfo);
}
