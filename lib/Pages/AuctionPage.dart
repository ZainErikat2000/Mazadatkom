import 'package:flutter/material.dart';

import '../DBs/Item_Model.dart';

class AuctionPage extends StatefulWidget {
  AuctionPage({
    Key? key,
    this.itemName,
    required this.minBid,
    required this.startPrice,
    required this.item
  }) : super(key: key);
  final String? itemName;
  final Item? item;
  final int? minBid;
  int? startPrice;

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  final TextEditingController bidCompareCont = TextEditingController();
  int? strtp;
  int? minb;

  @override
  Widget build(BuildContext context) {

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
            const SizedBox(
              width: 150,
              height: 150,
              child: DecoratedBox(
                child: Icon(Icons.image),
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
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
            Container(
                width: 100,
                child: TextFormField(
                  controller: bidCompareCont,
                  decoration: const InputDecoration(labelText: 'Bid'),
                )),
            ElevatedButton(
              onPressed: () {
                //bidding main func
                print("$strtp");
                String bidtext = bidCompareCont.text;
                if (bidtext == '') {
                  print('no bid input');
                } else {
                  int? currentbid = int.parse(bidtext);
                  print('${int.parse(minb.toString())}');
                  if (currentbid > int.parse(minb.toString())) {
                    setState(() => widget.startPrice = (strtp! + currentbid));
                  }
                }
                print("$strtp");
              },
              child: const Text("Bid: "),
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
