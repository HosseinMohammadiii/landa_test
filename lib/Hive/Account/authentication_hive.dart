import 'package:hive/hive.dart';

part 'authentication_hive.g.dart';

//AccountHive class for save authentication info
@HiveType(typeId: 0)
class AccountHive extends HiveObject {
  @HiveField(0)
  bool? isLogin;

  @HiveField(1)
  String? token;

  @HiveField(2)
  String? id;

  @HiveField(3)
  String? userName;

  //AccountHive constructor
  AccountHive({
    this.isLogin,
    this.token,
    this.id,
    this.userName,
  });
}
