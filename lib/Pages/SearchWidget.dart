import 'package:flutter/material.dart';
import 'package:mazadatkom/Pages/AuctionPage.dart';
import 'package:mazadatkom/Pages/ItemWidget.dart';
import 'package:mazadatkom/Pages/ItemForm.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Icon searchIcon = const Icon(Icons.search);
  Widget searchBar = const Text("Search");
  int listItemsCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        centerTitle: true,
        actions: <Widget>[
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
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ItemBox(
                color: index.isOdd ? Colors.grey[300] : Colors.white,
                itemName: 'Item ${index + 1}',
                description: "This is item ${index + 1} ",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuctionPage(),
                    ),
                  );
                },
              );
            },
            itemCount: listItemsCount,
          ),
        ),
      ),
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
