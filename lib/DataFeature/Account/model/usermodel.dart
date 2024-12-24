class UserModel {
  String email;
  String userName;
  String firstName;
  String mobile;
  String currency;
  String language;
  //UserModel constructor model
  UserModel({
    required this.email,
    required this.userName,
    required this.firstName,
    required this.mobile,
    required this.currency,
    required this.language,
  });
//UserModel factory constructor model
  factory UserModel.fromJson(Map<String, dynamic> jsonObject) {
    return UserModel(
      email: jsonObject['email'],
      userName: jsonObject['username'],
      firstName: jsonObject['first_name'],
      mobile: jsonObject['mobile'] ?? 'Empty',
      currency: jsonObject['currency'] ?? 'Empty',
      language: jsonObject['language'] ?? 'Empty',
    );
  }
}
