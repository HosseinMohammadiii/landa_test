import 'package:bloc/bloc.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_event.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_state.dart';

import '../data/repository/account_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AuthAccountRepository repository;
  AccountBloc(this.repository) : super(AuthInitiateState()) {
    on<AuthRegisterRequest>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AccountLoadingState());
          var register = await repository.registerUser(
              event.email, event.userName, event.password);
          emit(AuthResponseState(register));
        } catch (e) {
          // Emits error state on failure
          emit(AccountErrorState());
        }
      },
    );
    on<AuthLoginRequest>(
      (event, emit) async {
        try {
          // Emits loading state
          emit(AccountLoadingState());
          var login = await repository.loginUser(event.email, event.password);
          emit(AuthResponseState(login));
        } catch (e) {
          // Emits error state on failure
          emit(AccountErrorState());
        }
      },
    );
    on<DisplayUserInformationEvent>(
      (event, emit) async {
        try {
          emit(UserInfoLoadingState());
          var displayUserInfo = await repository.getDisplayUserInfo();
          emit(UserInfoResponseState(displayUserInfo));
        } catch (e) {
          emit(AccountErrorState());
        }
      },
    );
  }
}
