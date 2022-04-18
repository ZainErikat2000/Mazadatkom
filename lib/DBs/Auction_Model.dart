class Auction {
  late final int? id;
  late final int startPrice;
  late final int minBid;

  Auction({
    required this.id,
    required this.startPrice,
    required this.minBid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_Price': startPrice,
      'min_Bid': minBid,
    };
  }

  Auction.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        startPrice = result['start_Price'],
        minBid = result['min_Bid'];
}
