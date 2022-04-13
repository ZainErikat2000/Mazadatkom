import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:mazadatkom/Pages/ItemWidget.dart';

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({Key? key}) : super(key: key);

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  Widget buildItemBox(BuildContext context) {
    return const ItemBox(
      color: Colors.white,
      itemName: '',
      description: '',
      date: '',
      minBid: 1,
      startPrice: 1,
    );
  }


  List<TextEditingController> _formInput = [new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),];

  void getFormInputs() async{
    Item item = Item(id: 1,name: _formInput[0].text , description: _formInput[1].text);

    await DataBaseHelper.instance.insertItem(item);
    await DataBaseHelper.instance.printItems();
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
              TextFormField(controller: _formInput[0],
                decoration: const InputDecoration(labelText: 'Item Name',),
              ),
              const SizedBox(height: 8),
              TextFormField(controller: _formInput[1],
                decoration:
                    const InputDecoration(labelText: 'Item Description'),
              ),
              const SizedBox(height: 8),
              TextFormField(controller: _formInput[2],
                decoration: const InputDecoration(labelText: 'Min Bid'),
              ),
              const SizedBox(height: 8),
              TextFormField(controller: _formInput[3],
                decoration: const InputDecoration(labelText: 'Start Price'),
              ),
              ElevatedButton(onPressed: () {getFormInputs();}, child: const Text('ok'))
            ],
          ),
        ),
      ),
    );
  }
}
