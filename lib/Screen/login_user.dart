import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_bloc.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_event.dart';
import 'package:flutter_landa_test/Screen/home.dart';
import 'package:flutter_svg/svg.dart';

import '../DataFeature/Account/auth_manager.dart';
import '../DataFeature/Account/bloc/account_state.dart';
import '../Widget/snackbar_message.dart';
import '../Widget/textfield.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({super.key});

  @override
  State<LoginUserScreen> createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  //Text editing controller variables
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Text focus nodes variables
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ورود به لاندا تست',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffAA8453),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              'images/logo.svg',
              height: 28,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TextfieldWidget(
                hint: 'پست الکترونیکی',
                txtController: emailController,
                txtFocusNode: emailFocusNode,
                txtInputType: TextInputType.emailAddress,
                txtInputAction: TextInputAction.next,
              ),
              TextfieldWidget(
                hint: 'رمز عبور',
                txtController: passwordController,
                txtFocusNode: passwordFocusNode,
                txtInputType: TextInputType.text,
                txtInputAction: TextInputAction.done,
                isShowPassword: true,
              ),
              const Spacer(),
              _btnLogin(),
            ],
          ),
        ),
      ),
    );
  }

  //Widget for register button
  Widget _btnLogin() {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountErrorState) {
          //Display SnackBar with error Register
          showSnackBarMessage(
            context: context,
            errorMessage: 'اتصال اینترنت خود را بررسی کنید',
            duration: 2,
          );
        }
        if (state is AuthResponseState) {
          state.response.fold(
            (error) {
              //Display SnackBar with error Register
              showSnackBarMessage(
                context: context,
                errorMessage: error,
                duration: 2,
              );
            },
            (login) {
              //Check not empty AuthManager token
              if (AuthManager().getToken().isNotEmpty) {
                BlocProvider.of<AccountBloc>(context)
                    .add(DisplayUserInformationEvent());

                //If not empty AuthManager token ,navigator push HomeScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            //Check textEditingControllers to not empty
            if (emailController.text.isEmpty ||
                passwordController.text.isEmpty) {
              //Display SnackBar with error Register
              showSnackBarMessage(
                context: context,
                errorMessage: 'تمامی فیلد ها را تکمیل کنید',
                duration: 1,
              );
              return;
            }
            //This condition is for when the status is not AuthLoading
            if (state is! AccountLoadingState) {
              // Trigger login event
              BlocProvider.of<AccountBloc>(context).add(
                AuthLoginRequest(
                  emailController.text,
                  passwordController.text,
                ),
              );
            }
          },
          child: Container(
            height: 45,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 40),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffAA8453),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.red,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Visibility(
                  visible: state is! AccountLoadingState,
                  replacement: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  child: const Text(
                    'ورود',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
