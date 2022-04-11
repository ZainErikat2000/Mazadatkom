import 'dart:io';
import 'package:mazadatkom/DBs/Auction_Model.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final _databaseName = 'mainDatabase.db';
  static final _databaseVersion = 1;

  //Items table variables
  static final _itemsTableName = 'Items';
  static final _itemColID = 'id';
  static final _itemColName = 'name';
  static final _itemColDescription = 'description';

  //Auction table variables
  static final _auctionTableName = 'Auctions';
  static final _auctionColID = 'id';
  static final _auctionColStartPrice = 'start_price';
  static final _auctionColMinBid = 'min_bid';

  //singleton
  DataBaseHelper._constructDB();
  static final DataBaseHelper instance = DataBaseHelper._constructDB();
  static late Database _database;

  //get the databse
  Future<Database> get database async {
    //check if null
    if (_database != null) return _database;

    //if NULL initialize
    _database = await _initiateDB();
    return _database;
  }

  //initialize the database
  _initiateDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure);
  }

  //Create table(s) when creating DB
  Future _onCreate(Database database, int version) async {
    //Create items table
    await database.execute('''
    CREATE TABLE $_itemsTableName(
    $_itemColID INT PRIMARY KEY,
    $_itemColName TEXT NOT NULL,
    $_itemColDescription TEXT NOT NULL
    )
    ''');

    //Create auctions table
    await database.execute('''
    CREATE TABLE $_auctionTableName(
    $_auctionColID INT NOT NULL,
    $_auctionColMinBid INT NOT NULL,
    $_auctionColStartPrice INT NOT NULL,
    FOREIGN KEY($_auctionColID) REFERENCES $_itemsTableName($_itemColID)
    )
    ''');
  }

  //Allow foreign keys
  static Future _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  //Update or insert item to items table
  Future<Item> updateInsertItem(Item item) async {
    Database database = await instance.database;

    var count = Sqflite.firstIntValue(
      await database.rawQuery('''
    SELECT COUNT(*) FROM $_itemsTableName WHERE $_itemColID = ?
    ''', [item.id]),
    );

    if(count == 0){
      await database.insert(_itemsTableName, item.toMap() , conflictAlgorithm: ConflictAlgorithm.replace);
    }
    else{
      await database.update(_itemsTableName, item.toMap(), where: "$_itemColID = ?", whereArgs: [item.id],);
    }

    return item;
  }

  //Update or insert item to items table
  Future<Auction> updateInsertAuction(Auction auction) async {
    Database database = await instance.database;

    var count = Sqflite.firstIntValue(
      await database.rawQuery('''
    SELECT COUNT(*) FROM $_auctionTableName WHERE $_auctionColID = ?
    ''', [auction.id]),
    );

    if(count == 0){
      await database.insert(_auctionTableName, auction.toMap() , conflictAlgorithm: ConflictAlgorithm.replace);
    }
    else{
      await database.update(_auctionTableName, auction.toMap(), where: "$_auctionColID = ?", whereArgs: [auction.id],);
    }

    return auction;
  }

  //fetch an item
  Future<Item> fetchItem(int id) async{
    Database database = await instance.database;

    List<Map<String, dynamic>> queryResults = await database.query(_itemsTableName , where: "$_itemColID = ?" , whereArgs: [id]);

    Item item = Item.fromMap(queryResults[0]);

    return item;
  }

  //fetch an auction
  Future<Auction> fetchAuction(int id) async{
    Database database = await instance.database;

    List<Map<String, dynamic>> queryResults = await database.query(_auctionTableName , where: "$_auctionColID = ?" , whereArgs: [id]);

    Auction auction = Auction.fromMap(queryResults[0]);

    return auction;
  }

  //fetch list of all items
  Future<List<Item>> fetchListOfItems() async {
    Database database = await instance.database;

    List<Map<String, dynamic>> queryResult = await database.query(_itemsTableName);

    List<Item> items = [];

    queryResult.forEach((result) {
      Item item = Item.fromMap(result);
      items.add(item);
    });

    return items;
  }

  Future<List<Auction>> fetchListOfAuctions() async {
    Database database = await instance.database;

    List<Map<String, dynamic>> queryResult = await database.query(_auctionTableName);

    List<Auction> auctions = [];

    queryResult.forEach((result) {
      Auction auction = Auction.fromMap(result);
      auctions.add(auction);
    });

    return auctions;
  }

  //Delete item and its auction
  Future deleteItem(int id) async{
    Database database = await instance.database;
    await database.delete(_itemsTableName , where: "$_itemColID = ?", whereArgs: [id]);
    await database.delete(_auctionTableName , where: "$_auctionTableName = ?", whereArgs: [id]);
  }


}
