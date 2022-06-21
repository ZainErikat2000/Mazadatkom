class Buyer {
  Buyer({
    required this.buyerID,
    required this.itemID,
    required this.beenBought
  });

  late int buyerID;
  late int itemID;
  late int beenBought;

  Map<String, dynamic> toMap() {
    return {
      'buyer_id': buyerID,
      'item_id': itemID,
      'been_bought': beenBought,
    };
  }

  Buyer.fromMap(Map<String,dynamic> result)
  : buyerID = result['buyer_id'],
  itemID = result['item_id'],
  beenBought = result['been_bought'];
}
