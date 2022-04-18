class Item {
  late final int? id;
  late final String name;
  late final String description;

  Item({
    required this.id,
    required this.name,
    required this.description
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  Item.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        name = result['name'],
        description = result['description'];
}
