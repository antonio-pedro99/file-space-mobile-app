class UserLoginModel {
  String email;
  String password;

  UserLoginModel({required this.password, required this.email});
  toMap() {
    return {"email": email, "password": password};
  }
}
