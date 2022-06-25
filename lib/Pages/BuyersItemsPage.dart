import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';

import '../DBs/User_Model.dart';
import 'ItemTile.dart';

class BuyerItemsPage extends StatelessWidget {
  const BuyerItemsPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        key: key,
        future: DataBaseHelper.instance.getBuyerItems(userID: user.id),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var dataLength = data!.length;

          return dataLength == 0
              ? const Center(
                  child: Text('no data found'),
                )
              : ListView.builder(
                  itemCount: dataLength,
                  itemBuilder: (context, i) => ItemTile(
                    color: i.isOdd ? Colors.grey[300] : Colors.white,
                    item: data[i],
                    description: data[i].description,
                    user: user,
                  ),
                );
        },
      ),
    );
  }
}
