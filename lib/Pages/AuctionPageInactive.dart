import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'dart:io';
import '../DBs/Auction_Model.dart';
import '../DBs/Item_Model.dart';

class AuctionPageInactive extends StatefulWidget {
  AuctionPageInactive(
      {Key? key,
      this.itemName,
      required this.minBid,
      required this.startPrice,
      required this.item})
      : super(key: key);
  final String? itemName;
  final Item? item;
  final int? minBid;
  int? startPrice;

  @override
  State<AuctionPageInactive> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPageInactive> {
  Auction? auction;
  String imagePath = '';

  @override
  void setState(VoidCallback fn) async {
    // TODO: implement setState
    super.setState(fn);
    auction = await DataBaseHelper.instance.getAuction(widget.item?.id ?? 0);
    imagePath = auction?.image ?? '';
  }

  final TextEditingController bidCompareCont = TextEditingController();
  int? strtp;
  int? minb;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {});
    });
    minb = widget.minBid;
    strtp = widget.startPrice;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Auction",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(File(imagePath,),),
            SizedBox(
              child: Text("${widget.item?.name}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Min Bid: ${widget.minBid}'),
                const SizedBox(
                  width: 8,
                  height: 1,
                ),
              ],
            ),
            Text('current price: $strtp'),
            Row(
              children: <Widget>[
                Text("Auction's at: ${auction?.date}  ${auction?.time}")
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Exit Auction"),
            )
          ],
        ),
      ),
    );
  }
}
