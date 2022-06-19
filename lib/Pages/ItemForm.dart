import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mazadatkom/DBs/Auction_Model.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:mazadatkom/DBs/UserItem_Model.dart';
import 'package:mazadatkom/Pages/ItemTile.dart';

import '../DBs/User_Model.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({Key? key, required this.user}) : super(key: key);
  final User? user;

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  Widget buildItemBox(BuildContext context) {
    return ItemTile(
      user: User(id: 1, name: '', email: '', password: ''),
      color: Colors.white,
      description: '',
      item: Item(id: 1, name: '', description: '', category: ''),
    );
  }

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

  int itemID = 1;

  final List<TextEditingController> _formInput = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (int i = 0; i < _formInput.length; i++) {
      _formInput[i].dispose();
    }
    super.dispose();
  }

  void getFormInputs() async {
    var itemsCount = await DataBaseHelper.instance.getItemsCount();

    if (dropDowVal == '' || dropDowVal == 'None') {
      print('choose category');
      return;
    }

    for (int i = 0; i < _formInput.length; i++) {
      if (_formInput[i].text == '') {
        print('reenter form');
        return;
      }
    }

    Item item = Item(
        id: itemsCount,
        name: _formInput[0].text,
        description: _formInput[1].text,
        category: dropDowVal);
    await DataBaseHelper.instance.insertItem(item);

    Auction auction = Auction(
        id: itemsCount,
        startPrice: int.parse(_formInput[3].text),
        minBid: int.parse(_formInput[2].text));
    await DataBaseHelper.instance.insertAuction(auction);

    UserItem userItem =
        UserItem(itemID: itemsCount ?? 0, userID: widget.user?.id ?? 0);

    await DataBaseHelper.instance.insertUserItem(userItem);
  }

  void printItems() async {
    await DataBaseHelper.instance.printItems();
    await DataBaseHelper.instance.printAuctions();
    await DataBaseHelper.instance.printUserItems();
  }

  void clearItems() async {
    await DataBaseHelper.instance.clearTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Item Info",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Category:   ',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton(
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
                ],
              ),
              TextFormField(
                controller: _formInput[0],
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _formInput[1],
                decoration:
                    const InputDecoration(labelText: 'Item Description'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _formInput[2],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(labelText: 'Min Bid'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _formInput[3],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(labelText: 'Start Price'),
              ),
              ElevatedButton(
                  onPressed: () {
                    getFormInputs();
                  },
                  child: const Text('ok')),
              ElevatedButton(
                onPressed: () {
                  printItems();
                },
                child: const Text('print log'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
