import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import '../DBs/DataBaseHelper.dart';
import '../DBs/User_Model.dart';
import 'ItemTile.dart';

class UserItemsPage extends StatelessWidget {
  const UserItemsPage({Key? key,this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        key: key,
        future: DataBaseHelper.instance.getUserItems(userID: user?.id ?? 0),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List? data = snapshot.data;
          int? dataLength = data?.length;

          return dataLength == 0
              ? const Center(
            child: Text('no data found'),
          )
              : ListView.builder(
            itemCount: dataLength,
            itemBuilder: (context, i) => ItemTile(
                color: i.isOdd ? Colors.grey[300] : Colors.white,
                item: data?[i] ?? Item(id: 1, name: 'no name', description: 'no description'),
                description: data?[i]?.description ?? 'no description'),
          );
        },
      ),
    );
  }
}
