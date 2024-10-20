class User {
  String? name;
  String? email;
  String? mobile;
  String? password;
  String? confirmPassword;

  User({this.name, this.email, this.mobile, this.password, this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
