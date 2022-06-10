class Item {
  late final int? id;
  late final String name;
  late final String description;
  late final String category;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
    };
  }

  Item.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        name = result['name'],
        description = result['description'],
  category = result['category'];
}
