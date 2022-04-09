import 'package:flutter/material.dart';

class AuctionPage extends StatelessWidget {
  const AuctionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(
              child: Text("Item"),
            ),
            ElevatedButton(
              onPressed: () {
                print("bidding");
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
