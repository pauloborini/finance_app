class User {
  final int? id;
  final String name;
  final String email;
  final int password;

  User(
      {this.id,
      required this.name,
      required this.email,
      required this.password});
}
