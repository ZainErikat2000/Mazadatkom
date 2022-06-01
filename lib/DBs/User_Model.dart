class User {
  late final int id;
  late final int name;
  late final int email;
  late final int password;

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