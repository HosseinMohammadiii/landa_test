import 'package:flutter_landa_test/DataFeature/Account/data/datasource/account_datasource.dart';
import 'package:flutter_landa_test/DataFeature/Account/data/repository/account_repository.dart';
import 'package:flutter_landa_test/DataFeature/NetworkUtil/dio_provider.dart';
import 'package:get_it/get_it.dart';

// Instance of GetIt for managing dependencies
var locator = GetIt.instance;

// Function to initialize and register dependencies
Future<void> getInInit() async {
  // Registering a singleton instance of Dio for making HTTP requests
  locator.registerSingleton(DioProvider.createDio());

  //locator Datasource
  locator.registerFactory<AuthenticationDataSource>(
    () => AuthAccountDataSourceRemoot(
      locator.get(),
    ),
  );

  //locator Repository
  locator.registerFactory<AuthAccountRepository>(
    () => AuthAccountRepositoryRemoot(
      locator.get(),
    ),
  );
}
