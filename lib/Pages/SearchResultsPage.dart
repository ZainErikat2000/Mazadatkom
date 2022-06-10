import 'package:flutter/material.dart';
import '../DBs/DataBaseHelper.dart';
import 'ItemTile.dart';

class SearchResultsPage extends StatelessWidget {
   SearchResultsPage({Key? key, required this.searchterm,required this.category}) : super(key: key);
  final String? searchterm;
  String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        key: key,
        future: DataBaseHelper.instance.searchForItems(searchTerm: searchterm ?? '',category: category),
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
