import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_landa_test/DataFeature/Account/auth_manager.dart';
import 'package:flutter_landa_test/DataFeature/Account/bloc/account_bloc.dart';
import 'package:flutter_landa_test/Hive/Account/authentication_hive.dart';
import 'package:flutter_landa_test/Screen/authentication.dart';
import 'package:flutter_landa_test/Screen/home.dart';
import 'package:hive_flutter/adapters.dart';

import 'DataFeature/NetworkUtil/di.dart';

void main() async {
  // Ensures that Flutter's widget binding is properly initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Hive for local storage.
  await Hive.initFlutter();

  // Registers Hive adapters for custom data types.
  Hive.registerAdapter(AccountHiveAdapter());

  // Opens Hive boxes for user login data.
  await Hive.openBox<AccountHive>('user_auth');

  // Registers services and repositories with GetIt dependency injection.
  await getInInit();

  runApp(
    BlocProvider(
      create: (context) => AccountBloc(
        locator.get(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //Checking if the token is not empty to display the HomeScreen
      home: AuthManager().getToken().isNotEmpty
          ? const HomeScreen()
          : const AuthenticationScreen(),
    );
  }
}
