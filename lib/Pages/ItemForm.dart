import 'package:flutter/material.dart';
import 'package:mazadatkom/Pages/ItemWidget.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({Key? key}) : super(key: key);

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {


  Widget buildItemBox(BuildContext context) {
    return ItemBox(
      color: Colors.white,
      itemName: '',
      description: '',
      date: '',
      minBid: 1,
      startPrice: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Item Info",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Item Description'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Min Bid'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Start Price'),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('ok'))
          ],
        ),
      ),
    );
  }
}
