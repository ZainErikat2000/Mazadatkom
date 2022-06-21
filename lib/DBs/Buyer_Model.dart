class Buyer {
  Buyer({
    required this.buyerID,
    required this.itemID,
  });

  late int buyerID;
  late int itemID;

  Map<String, dynamic> toMap() {
    return {
      'buyer_id': buyerID,
      'item_id': itemID,
    };
  }

  Buyer.fromMap(Map<String,dynamic> result)
  : buyerID = result['buyer_id'],
  itemID = result['item_id'];
}
