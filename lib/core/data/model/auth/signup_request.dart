class SignUpReq {
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String email;

  SignUpReq(
      {required this.firstName,
      required this.lastName,
      required this.userName,
      required this.password,
      required this.email});
}
