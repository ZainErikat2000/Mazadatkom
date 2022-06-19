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

  //initState can't handle async methods thus I used setState
  @override
  void setState(VoidCallback fn) async {
    // TODO: implement setState
    super.setState(fn);
    try {
      //calling the auction of the item from here
      auction = await _getUserAuction();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Text('Description ${widget.item?.description ?? 'no description'}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Start Price: ${auction?.startPrice ?? 1}    Min Bid: ${auction?.minBid ?? 1}'),
            ],
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
              ))
        ],
      ),
    );
  }

  //get auction
  Future<Auction> _getUserAuction() async {
    return await DataBaseHelper.instance.getAuction(widget.item?.id ?? 0);
  }
}
