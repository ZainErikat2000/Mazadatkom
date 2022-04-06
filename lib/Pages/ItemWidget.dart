import 'package:flutter/material.dart';

class ItemBox extends StatelessWidget {
  const ItemBox(
      {Key? key,
        required this.color,
      required this.itemName,
      required this.description,
       this.date,
       this.minBid,
       this.startPrice,
       this.onPressed})
      : super(key: key);

  final String itemName;
  final String description;
  final int? startPrice;
  final int? minBid;
  final String? date;
  final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: ListTile(
        onTap: onPressed,
        title: Text(itemName),
        subtitle: Text(description),
        leading: Icon(Icons.adjust,),
      ),
    );
  }
}
