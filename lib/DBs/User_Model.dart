class User {
  late final int id;
  late final String name;
  late final String email;
  late final String password;
  late final String contactInfo;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.contactInfo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'pass': password,
      'info': contactInfo,
    };
  }

  User.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        name = result['name'],
        email = result['email'],
        password = result['pass'],
        contactInfo = result['info'];
}
