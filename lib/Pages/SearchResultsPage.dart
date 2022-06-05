import 'package:flutter/material.dart';
import '../DBs/DataBaseHelper.dart';
import 'ItemTile.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({Key? key, required this.searchterm}) : super(key: key);
  final String? searchterm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        key: key,
        future: DataBaseHelper.instance.searchForItems(searchTerm: searchterm ?? ''),
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
                  itemBuilder: (context, i) => ItemTile(
                      color: i.isOdd ? Colors.grey[300] : Colors.white,
                      item: data[i],
                      description: data[i].description),
                );
        },
      ),
    );
  }
}
