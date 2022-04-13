import 'dart:io';
import 'package:mazadatkom/DBs/Auction_Model.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const _databaseName = 'mainDatabase.db';
  static const _databaseVersion = 1;

  //Items table variables
  static const _itemsTableName = 'Items';
  static const _itemColID = 'id';
  static const _itemColName = 'name';
  static const _itemColDescription = 'description';

  //Auction table variables
  static const _auctionTableName = 'Auctions';
  static const _auctionColID = 'id';
  static const _auctionColStartPrice = 'start_price';
  static const _auctionColMinBid = 'min_bid';

  //singleton
  DataBaseHelper._constructDB();
  static final DataBaseHelper instance = DataBaseHelper._constructDB();
  static Database? _database;

  //get the database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initiateDB();
    return _database;
  }

  //initialize the database
  Future<Database?> _initiateDB() async {
    print('getting database path');
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = join(directory.path, _databaseName);
    print(path);
    return await openDatabase(path,
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
  Future<void> insertItem(Item item) async {
    Database? database = await instance.database;
    await database?.insert(_itemsTableName, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateItem(Item item) async {
    Database? database = await instance.database;

    await database?.update(_itemsTableName, item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> insertAuction(Auction auction) async {
    Database? database = await instance.database;

    await database?.insert(_auctionTableName, auction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateAuction(Auction auction) async {
    Database? database = await instance.database;

    await database?.update(_itemsTableName, auction.toMap(),
        where: 'id = ?', whereArgs: [auction.id]);
  }

  Future<void> printItems() async {
    Database? database = await instance.database;

    if (database == null) print('no database');

    //prints table rows
    (await database?.query(_itemsTableName,
            columns: [_itemColID,_itemColName, _itemColDescription]))
        ?.forEach((row) {
      print(row);
    });
  }

  Future<void> clearItemsTable() async{
    //NO BETTER WAY OF CLEARING THE TABLE
    Database? database = await instance.database;
    database?.execute('DROP TABLE IF EXISTS $_itemsTableName');
    await database?.execute('''
    CREATE TABLE $_itemsTableName(
    $_itemColID INT PRIMARY KEY,
    $_itemColName TEXT NOT NULL,
    $_itemColDescription TEXT NOT NULL
    )
    ''');
  }
}
