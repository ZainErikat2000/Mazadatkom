class User {
  late final int id;
  late final String name;
  late final String email;
  late final String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'pass': password,
    };
  }

  User.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        name = result['name'],
        email = result['email'],
        password = result['pass'];
}