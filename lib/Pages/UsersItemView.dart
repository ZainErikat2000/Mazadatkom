import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:mazadatkom/DBs/User_Model.dart';

import '../DBs/Auction_Model.dart';
import '../DBs/Buyer_Model.dart';

class UsersItemView extends StatefulWidget {
  const UsersItemView({Key? key, this.item}) : super(key: key);
  final Item? item;

  @override
  _UsersItemViewState createState() => _UsersItemViewState();
}

class _UsersItemViewState extends State<UsersItemView> {
  Auction? auction;
  String activeStatus = 'No';
  String activeStatusButton = 'Activate';
  String warningText = '';

  //initState can't handle async methods thus I used setState
  @override
  void setState(VoidCallback fn) async {
    // TODO: implement setState

    try {
      //calling the auction of the item from here
      auction = await _getUserAuction();
    } catch (e) {
      print(e.toString());
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {});
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item State'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.item?.name ?? 'no name',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('Description: ${widget.item?.description ?? 'no description'}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Start Price: ${auction?.startPrice}    Min Bid: ${auction?.minBid}'),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text('Is active?: ${auction?.isActive == 1 ? 'Yes' : 'No'}'),
          Text(
            warningText,
            style: const TextStyle(color: Colors.redAccent),
          ),
          ElevatedButton(
            onPressed: () async {
              int status = auction?.isActive ?? 0;
              bool wasBought = await DataBaseHelper.instance
                  .checkBought(widget.item?.id ?? 0);

              bool pendingBought = await DataBaseHelper.instance
                  .checkBuyerAndItem(widget.item?.id ?? 0);

              Buyer? buyer =
                  await DataBaseHelper.instance.getBuyer(widget.item?.id ?? 0);

              if (wasBought) {
                User name = await DataBaseHelper.instance
                    .getUserByID(buyer?.buyerID ?? 0);
                setState(() {
                  warningText = '''already bought by "${name.name}"
                  Phone Number: ${name.contactInfo}''';
                });
                return;
              }

              if (status == 0) {
                await DataBaseHelper.instance.updateAuction(
                  Auction(
                    id: auction?.id,
                    minBid: auction?.minBid ?? 0,
                    startPrice: auction?.startPrice ?? 0,
                    isActive: 1,
                    date: auction?.date ?? '',
                    time: auction?.time ?? '',
                    image: auction?.image ?? '',
                  ),
                );
              } else {
                if (!pendingBought) {
                  setState(() {
                    warningText = 'no buyers yet';
                  });
                  return;
                }

                await DataBaseHelper.instance.updateBuyerItem(
                  Buyer(
                      buyerID: buyer?.buyerID ?? 0,
                      itemID: buyer?.itemID ?? 0,
                      beenBought: 1),
                );

                await DataBaseHelper.instance.updateAuction(
                  Auction(
                    id: auction?.id,
                    minBid: auction?.minBid ?? 0,
                    startPrice: auction?.startPrice ?? 0,
                    isActive: 0,
                    date: auction?.date ?? '',
                    time: auction?.time ?? '',
                    image: auction?.image ?? '',
                  ),
                );
              }
              auction =
                  await DataBaseHelper.instance.getAuction(auction?.id ?? 0);
              setState(() {});
            },
            child: Text(
              auction?.isActive == 1 ? 'Deactivate' : 'Activate',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //get auction
  Future<Auction> _getUserAuction() async {
    return await DataBaseHelper.instance.getAuction(widget.item?.id ?? 0);
  }
}
