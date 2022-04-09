class Item {
  late final int id;
  late final String name;

  Item({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Item.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        name = result['name'];
}
