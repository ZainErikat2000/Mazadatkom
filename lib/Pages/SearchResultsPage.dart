import 'package:flutter/material.dart';
import '../DBs/DataBaseHelper.dart';
import '../DBs/User_Model.dart';
import 'ItemTile.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage(
      {Key? key, required this.searchTerm, required this.category,required this.user})
      : super(key: key);
  final String? searchTerm;
  String category;
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        key: key,
        future: DataBaseHelper.instance
            .searchForItems(searchTerm: searchTerm ?? '', category: category),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var dataLength = data!.length;

          return dataLength == 0
              ? Center(
                  child: Text('no data found'),
                )
              : ListView.builder(
                  itemCount: dataLength,
                  itemBuilder: (context, i) => ItemTile(user: user,
                      color: i.isOdd ? Colors.grey[300] : Colors.white,
                      item: data[i],
                      description: data[i].description),
                );
        },
      ),
    );
  }
}
