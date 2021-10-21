class UserModel {
  String name;
  String email;
  String password;

  UserModel({
    this.name = '',
    this.email = '',
    this.password = '',
  });

  @override
  String toString() => 'UserModel(name: $name, email: $email, password: $password)';
}
