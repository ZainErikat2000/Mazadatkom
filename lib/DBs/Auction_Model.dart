class Auction {
  late final int id;
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
      'startPrice': startPrice,
      'minBid': minBid,
    };
  }

  Auction.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        startPrice = result['startPrice'],
        minBid = result['minBid'];
}
