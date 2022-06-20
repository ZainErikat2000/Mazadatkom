import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:mazadatkom/DBs/UserItem_Model.dart';
import 'package:mazadatkom/Pages/AuctionPageInactive.dart';
import 'package:mazadatkom/Pages/UsersItemView.dart';
import '../DBs/Auction_Model.dart';
import '../DBs/User_Model.dart';
import 'AuctionPage.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(
      {Key? key,
      required this.user,
      required this.color,
      required this.description,
      required this.item})
      : super(key: key);

  final User user;
  final String description;
  final Color? color;
  final Item? item;
  //declared a static void Function to build the auction page independently of each item tile

  static void Function(
          BuildContext context, int? mb, int? sp, Item it, User us, int ac
          //nothing to worry about
          ) onPressed =
      (BuildContext context, int? mb, int? sp, Item it, User us, int ac) async {
    UserItem userItem = await DataBaseHelper.instance.getUserItem(it.id ?? 0);

    if (us.id != userItem.userID) {
      if(ac == 1)
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
      else{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuctionPageInactive(
              minBid: mb,
              startPrice: sp,
              item: it,
            ),
          ),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsersItemView(item: it),
        ),
      );
    }
  };

  @override
  Widget build(BuildContext context) {
    int isActive = 0;

    return Container(
      color: color,
      child: ListTile(
        onTap: () async {
          Auction auction =
              await DataBaseHelper.instance.getAuction(item?.id ?? 0);
          int min = auction.minBid;
          int startPrice = auction.startPrice;
          int ac = auction.isActive;

          onPressed(context, min, startPrice, item!, user, ac);
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
