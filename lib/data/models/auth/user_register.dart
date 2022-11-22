class UserSignUpModel {
  String email;
  String password;
  String name;
  String phoneNumber;

  UserSignUpModel(
      {required this.password,
      required this.phoneNumber,
      required this.email,
      required this.name});
      
  toMap() {
    return {"email": email, "password": password, "phoneNumber": phoneNumber};
  }
}
