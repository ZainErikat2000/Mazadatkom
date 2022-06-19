import 'package:flutter/material.dart';
import 'package:mazadatkom/Custom_Widgets/ItemsList.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/Pages/AuctionPage.dart';
import 'package:mazadatkom/Pages/ItemTile.dart';
import 'package:mazadatkom/Pages/ItemForm.dart';
import 'package:mazadatkom/Pages/SearchResultsPage.dart';
import 'package:mazadatkom/Pages/UserItemsPage.dart';

import '../DBs/User_Model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key, required this.user}) : super(key: key);
  final User? user;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  Icon searchIcon = const Icon(Icons.search);
  Icon refreshIcon = const Icon(Icons.input);
  Widget searchBar = const Text("Search");
  int listItemsCount = 5;

  List<DropdownMenuItem<String>> categories = [
    const DropdownMenuItem(
      child: Text('None'),
      value: 'None',
    ),
    const DropdownMenuItem(
      child: Text('Antique'),
      value: 'Antique',
    ),
    const DropdownMenuItem(
      child: Text('Tech'),
      value: 'Tech',
    ),
    const DropdownMenuItem(
      child: Text('Other'),
      value: 'Other',
    )
  ];
  var dropDowVal = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Text('User'),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserItemsPage(
                      user: widget.user,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.person,
              ),
            )
          ],
        ),
      ),
      //search controls within appbar
      appBar: AppBar(
        title: searchBar,
        centerTitle: true,
        actions: <Widget>[DropdownButton(
        value: dropDowVal,
        items: categories,
        onChanged: (category) {
          if (category is String) {
            setState(
                  () {
                dropDowVal = category;
              },
            );
          }
        },
      ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsPage(
                      searchTerm: searchController.text,
                      category: dropDowVal,
                      user: widget.user!,
                    ),
                  ),
                );
              },
              icon: refreshIcon),
          IconButton(
            onPressed: () {
              setState(() {
                if (searchIcon.icon == Icons.search) {
                  searchIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Enter query",
                    ),
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
        child: ItemsList(user: widget.user!),
      ),

      //floating action button to add items
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemFormPage(
                        user: widget.user,
                      )));
        },
        tooltip: 'increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
