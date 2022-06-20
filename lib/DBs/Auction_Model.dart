class Auction {
  late final int? id;
  late final int startPrice;
  late final int minBid;
  late final int isActive;

  Auction({
    required this.id,
    required this.startPrice,
    required this.minBid,
    required this.isActive
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_price': startPrice,
      'min_bid': minBid,
      'is_active': isActive,
    };
  }

  Auction.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        startPrice = result['start_price'],
        minBid = result['min_bid'],
        isActive = result['is_active'];
}
