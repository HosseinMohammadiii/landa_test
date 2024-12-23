import 'package:flutter/material.dart';

import 'package:flutter_landa_test/Screen/login_user.dart';
import 'package:flutter_landa_test/Screen/register_user.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'images/logo.svg',
                height: 200,
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: Text(
                  'لاندا تست',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color(0xffAA8453),
                      ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buttonWidget(
                    screen: const LoginUserScreen(),
                    txt: 'ورود',
                    containerColor: Colors.transparent,
                    txtColor: Colors.red,
                  ),
                  _buttonWidget(
                    screen: const RegisterUserScreen(),
                    txt: 'ثبت نام',
                    containerColor: const Color(0xffAA8453),
                    txtColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//Button widget for Register and Login user
  Widget _buttonWidget({
    required String txt,
    required Widget screen,
    required Color containerColor,
    required Color txtColor,
  }) {
    return GestureDetector(
      onTap: () {
        //Navigator push Screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      child: Container(
        width: 100,
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red),
        ),
        child: Text(
          txt,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: txtColor,
              ),
        ),
      ),
    );
  }
}
