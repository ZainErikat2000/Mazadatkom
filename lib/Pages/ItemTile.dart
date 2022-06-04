import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import '../DBs/Auction_Model.dart';
import 'AuctionPage.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(
      {Key? key,
      required this.color,
      this.itemName,
      required this.description,
      this.date,
      this.minBid,
      this.startPrice,
      required this.item})
      : super(key: key);

  final String? itemName;
  final String description;
  final int? startPrice;
  final int? minBid;
  final String? date;
  final Color? color;
  final Item? item;
  //declared a static void Function to build the auction page independently of each item tile
  static void Function(
    BuildContext context,
    int? mb,
    int? sp,
    Item it,
  ) onPressed = (BuildContext context, int? mb, int? sp, Item it) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuctionPage(
          minBid: mb,
          startPrice: sp,
          item: it,
        ),
      ),
    );
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: ListTile(
        onTap: () async {
          Auction auction =
              await DataBaseHelper.instance.getAuction(item?.id ?? 0);
          int min = auction.minBid;
          int startPrice = auction.startPrice;

          onPressed(context, min, startPrice, item!);
        },
        title: Text(item?.name ?? ''),
        subtitle: Text(description),
        leading: const Icon(
          Icons.adjust,
        ),
      ),
    );
  }

  /*
  //FORBIDDEN METHOD DON'T TOUCH
  _routeToAuctionPage(BuildContext context) {
    Future.microtask(
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuctionPage(
            itemName: itemName,
            minBid: minBid,
            startPrice: startPrice,
          ),
        ),
      ),
    );
  }
   */
}
