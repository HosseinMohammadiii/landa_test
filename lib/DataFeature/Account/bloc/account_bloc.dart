import 'package:bloc/bloc.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_event.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_state.dart';

import '../data/repository/account_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AuthAccountRepository repository;
  AccountBloc(this.repository) : super(AuthInitiateState()) {
    //Handle AuthRegisterRequest event
    on<AuthRegisterRequest>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AccountLoadingState());
          //Initialize the register variable with the registerUser method of the repository
          var register = await repository.registerUser(
              event.email, event.userName, event.password);
          // Emits AuthResponseState
          emit(AuthResponseState(register));
        } catch (e) {
          // Emits error state on failure
          emit(AccountErrorState());
        }
      },
    );
    //Handle AuthLoginRequest event
    on<AuthLoginRequest>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AccountLoadingState());
          //Initialize the login variable with the loginUser method of the repository
          var login = await repository.loginUser(event.email, event.password);
          emit(AuthResponseState(login));
        } catch (e) {
          // Emits error state on failure
          emit(AccountErrorState());
        }
      },
    );
    //Handle DisplayUserInformationEvent event
    on<DisplayUserInformationEvent>(
      (event, emit) async {
        try {
          // Emits UserInfoLoadingState
          emit(UserInfoLoadingState());
          //Initialize the displayUserInfo variable with the getDisplayUserInfo method of the repository
          var displayUserInfo = await repository.getDisplayUserInfo();
          // Emits UserInfoResponseState
          emit(UserInfoResponseState(displayUserInfo));
        } catch (e) {
          // Emits AccountErrorState
          emit(AccountErrorState());
        }
      },
    );
  }
}
