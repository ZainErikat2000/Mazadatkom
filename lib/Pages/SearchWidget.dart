import 'package:flutter/material.dart';
import 'package:mazadatkom/Custom_Widgets/ItemsList.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/Pages/AuctionPage.dart';
import 'package:mazadatkom/Pages/ItemTile.dart';
import 'package:mazadatkom/Pages/ItemForm.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Icon searchIcon = const Icon(Icons.search);
  Icon refreshIcon = const Icon(Icons.refresh);
  Widget searchBar = const Text("Search");
  int listItemsCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //search widget within appbar
      appBar: AppBar(
        title: searchBar,
        centerTitle: true,
        actions: <Widget>[IconButton(onPressed:() {setSate(){}}, icon: refreshIcon),
          IconButton(
            onPressed: () {
              setState(() {
                if (searchIcon.icon == Icons.search) {
                  searchIcon = const Icon(Icons.cancel);
                  searchBar = const TextField(
                    decoration: InputDecoration(hintText: "Enter query"),
                  );
                } else {
                  searchIcon = const Icon(Icons.search);
                  searchBar = const Text("Search");
                }
              });
            },
            icon: searchIcon,
          ),
        ],
      ),

      //listview within the container
      body: Container(
        color: Colors.grey[300],
        child: ItemsList(),
      ),

      //floating action button to add items
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ItemFormPage()));
        },
        tooltip: 'increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
