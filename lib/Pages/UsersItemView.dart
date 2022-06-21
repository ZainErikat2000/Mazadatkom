import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';

import '../DBs/Auction_Model.dart';

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
          ElevatedButton(
            onPressed: () async {
              int status = auction?.isActive ?? 0;
              if (status == 0) {
                await DataBaseHelper.instance.updateAuction(
                  Auction(
                      id: auction?.id,
                      minBid: auction?.minBid ?? 0,
                      startPrice: auction?.startPrice ?? 0,
                      isActive: 1,
                      date: auction?.date ?? '',
                      time: auction?.time ?? ''),
                );
              } else {
                await DataBaseHelper.instance.updateAuction(
                  Auction(
                      id: auction?.id,
                      minBid: auction?.minBid ?? 0,
                      startPrice: auction?.startPrice ?? 0,
                      isActive: 0,
                      date: auction?.date ?? '',
                      time: auction?.time ?? ''),
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
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              await DataBaseHelper.instance.deleteItem(widget.item?.id ?? 0);
              Navigator.pop(context);
            },
            child: const Text(
              'DELETE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
