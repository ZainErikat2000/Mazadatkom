import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mazadatkom/DBs/Auction_Model.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/DBs/User_Model.dart';

import '../DBs/Buyer_Model.dart';
import '../DBs/Item_Model.dart';

class AuctionPage extends StatefulWidget {
  AuctionPage(
      {Key? key,
      this.itemName,
      required this.minBid,
      required this.startPrice,
      required this.item,
      required this.user})
      : super(key: key);
  final String? itemName;
  final Item? item;
  final int? minBid;
  int? startPrice;
  final User user;

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  final TextEditingController bidTextController = TextEditingController();
  Auction? auction;
  String warningText = '';

  @override
  void setState(VoidCallback fn) async {
    // TODO: implement setState
    super.setState(fn);
    auction = await DataBaseHelper.instance.getAuction(widget.item?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {});
    });
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
            Image.network('https://picsum.photos/200'),
            SizedBox(
              child: Text("${widget.item?.name}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Min Bid: ${auction?.minBid}'),
                const SizedBox(
                  width: 8,
                  height: 1,
                ),
              ],
            ),
            Text('current price: ${auction?.startPrice}'),
            Container(
              width: 100,
              child: TextFormField(
                controller: bidTextController,
                decoration: const InputDecoration(labelText: 'Bid'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                int? currentBid = int.parse(bidTextController.text);
                int minBid = auction?.minBid ?? 0;
                if (currentBid < minBid) {
                  print('below');
                  setState(() {
                    warningText = 'below minimum bid';
                  });
                  return;
                }

                setState(() {
                  warningText = '';
                  return;
                });

                int nullPrice =auction?.startPrice ?? 0;
                int newPrice =  nullPrice + currentBid;
                  await DataBaseHelper.instance.updateAuction(
                    Auction(
                      id: auction?.id ?? 0,
                      minBid: auction?.minBid ?? 0,
                      date: auction?.date ?? '',
                      startPrice: newPrice,
                      time: auction?.time ?? '',
                      isActive: auction?.isActive ?? 0,
                      image: auction?.image ?? '',
                    ),
                  );

                  //decide wither to insert or update the buyer tuple
                  bool buyerExists =
                      await DataBaseHelper.instance.checkBuyerAndItem(
                    widget.item?.id ?? 0,
                  );

                  //check if item was bought
                  bool wasBought =
                      await DataBaseHelper.instance.checkBuyerAndItem(
                    widget.item?.id ?? 0,
                  );

                  if (wasBought) {
                    return;
                  }

                  if (buyerExists) {
                    await DataBaseHelper.instance.updateBuyerItem(
                      Buyer(
                          buyerID: widget.user.id,
                          itemID: widget.item?.id ?? 0,
                          beenBought: 0),
                    );
                  } else {
                    await DataBaseHelper.instance.insertBuyerItem(
                      Buyer(
                          buyerID: widget.user.id,
                          itemID: widget.item?.id ?? 0,
                          beenBought: 0),
                    );
                  }

              },
              child: const Text("Bid: "),
            ),
            Text(
              warningText,
              style: const TextStyle(
                color: Colors.redAccent,
              ),
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
