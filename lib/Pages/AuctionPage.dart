import 'package:flutter/material.dart';

class AuctionPage extends StatelessWidget {
  const AuctionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          "Auction",
        ),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              child: Text("Item Image"),
            ),
            ElevatedButton(
              onPressed: () {
                print("bidding");
              },
              child: Text("Bid: "),
            ),
            ElevatedButton(
              onPressed: () {Navigator.pop(context);},
              child: const Text("Exit Auction"),
            )
          ],
        ),
      ),
    );
  }
}
