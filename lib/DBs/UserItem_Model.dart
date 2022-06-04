class UserItem {
  UserItem({this.itemID = 0, this.userID = 0});

  late int itemID;
  late int userID;

  Map<String, dynamic> toMap() {
    return {'item_id': itemID, 'user_id': userID};
  }

  UserItem.fromMap(Map<String, dynamic> result)
      : itemID = result['item_id'],
        userID = result['user_id'];
}