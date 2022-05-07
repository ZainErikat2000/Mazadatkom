import 'dart:math';
import 'package:flutter/material.dart';
import 'AuctionPage.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.color,
    required this.itemName,
    required this.description,
    this.date,
    this.minBid,
    this.startPrice,
  }) : super(key: key);

  final String itemName;
  final String description;
  final int? startPrice;
  final int? minBid;
  final String? date;
  final Color? color;
  //declared a static void Function to build the auction page independently of each item tile
  static void Function(
    BuildContext context,
    String name,
    int? mb,
    int? sp,
  ) onPressed = (
    BuildContext context,
    String name,
    int? mb,
    int? sp,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuctionPage(
          itemName: name,
          minBid: mb,
          startPrice: sp,
        ),
      ),
    );
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: ListTile(
        onTap: () {
          //REMOVE v
          Random rnd = Random();
          int? rndStart = rnd.nextInt(76) + 25;
          int? rndMin = rnd.nextInt(11) + 3;
          //REMOVE ^
          onPressed(context, itemName, rndMin, rndStart);},
        title: Text(itemName),
        subtitle: Text(description),
        leading: Icon(
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
