abstract class AccountEvent {}

//DisplayUserInformationEvent event bloc to display users informations
final class DisplayUserInformationEvent extends AccountEvent {}

//AuthLoginRequest event bloc to login user
final class AuthLoginRequest extends AccountEvent {
  String email;
  String password;

  AuthLoginRequest(this.email, this.password);
}

//AuthRegisterRequest event bloc to register user
final class AuthRegisterRequest extends AccountEvent {
  String email;
  String userName;
  String password;

  AuthRegisterRequest(this.email, this.userName, this.password);
}
