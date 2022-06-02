import 'dart:io';
import 'package:mazadatkom/DBs/Auction_Model.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:mazadatkom/DBs/User_Model.dart';
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

  //User table variables
  static const _userTableName = 'Users';
  static const _userColID = 'id';
  static const _userColName = 'name';
  static const _userColEmail = 'email';
  static const _userColPass = 'pass';

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
    $_itemColID INT PRIMARY KEY NOT NULL,
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

    await database.execute('''
    CREATE TABLE $_userTableName(
    $_userColID INT NOT NULL,
    $_userColName TEXT NOT NULL,
    $_userColEmail TEXT NOT NULL,
    $_userColPass TEXT NOT NULL
    )
    ''');
  }

  //Allow foreign keys
  static Future _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  //items table operations
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

  Future<int?> getItemsCount()async{
    Database? database = await instance.database;
    List<Map>? result = await database?.query(_itemsTableName);
    return result?.length;
  }

  //auctions table operations
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

    //prints table rows
    (await database?.query(_itemsTableName,
            columns: [_itemColID,_itemColName, _itemColDescription]))
        ?.forEach((row) {
      print(row);
    });
  }

  //users table operations
  Future<void> insertUser(User user) async {
    Database? database = await instance.database;
    await database?.insert(_userTableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(User user) async {
    Database? database = await instance.database;
    await database?.update(_userTableName, user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int?> getUsersCount()async{
    Database? database = await instance.database;
    List<Map>? result = await database?.query(_userTableName);
    return result?.length;
  }

  Future<bool> validateSignUp(String? name, String? email) async{
    Database? database = await instance.database;

    //check if name is in use
    List<Map> nameResult = await database?.query(_userTableName, where: '$_userColName = ?',whereArgs: [name]) ?? List.filled(0,
        {});
    if(!nameResult.isEmpty){
      return false;
    }


    //check if email is in use
    print('email exists');
    List<Map> emailResult = await database?.query(_userTableName, where: '$_userColEmail = ?',whereArgs: [email]) ?? List.filled(0,
    {});
    if(!emailResult.isEmpty){
      return false;
    }

    //complete normally
    return true;
  }

  Future<bool> validateSignIn(String name, String pass) async{
    Database? database = await instance.database;

    //check if name is in use
    List<Map>? nameResult = await database?.query(_userTableName, where: '$_userColName = ?',whereArgs: [name]);
    if(nameResult == null){
      return false;
    }

    //check if email is in use
    List<Map>? passResult = await database?.query(_userTableName, where: '$_userColPass = ?',whereArgs: [pass]);
    if(pass != passResult![0][_userColPass]){
      return false;
    }

    //complete normally
    return true;
  }

  Future<void> printUsers() async {
    Database? database = await instance.database;

    print('printing users');
    //prints table rows
    (await database?.query(_userTableName,
        columns: [_userColID,_userColName, _userColEmail,_userColPass]))
        ?.forEach((row) {
      print(row);
    });
  }

  //other operations
  Future<void> printAuctions() async {
    Database? database = await instance.database;

    //prints table rows
    (await database?.query(_auctionTableName,
        columns: [_auctionColID,_auctionColStartPrice, _auctionColMinBid]))
        ?.forEach((row) {
      print(row);
    });
  }

  Future<void> clearTables() async{
    //NO BETTER WAY OF CLEARING THE TABLE
    Database? database = await instance.database;
    await database?.execute('DROP TABLE IF EXISTS $_auctionTableName');
    await database?.execute('DROP TABLE IF EXISTS $_itemsTableName');


    await database?.execute('''
    CREATE TABLE $_itemsTableName(
    $_itemColID INT PRIMARY KEY,
    $_itemColName TEXT NOT NULL,
    $_itemColDescription TEXT NOT NULL
    )
    ''');

    await database?.execute('''
    CREATE TABLE $_auctionTableName(
    $_auctionColID INT NOT NULL,
    $_auctionColMinBid INT NOT NULL,
    $_auctionColStartPrice INT NOT NULL,
    FOREIGN KEY($_auctionColID) REFERENCES $_itemsTableName($_itemColID)
    )
    ''');
  }

  //listview related operations
  Future<List<Item>> getItems() async{
    final database = await instance.database;

    List<Map<String, dynamic>>? items = await database?.query(_itemsTableName, orderBy: 'id DESC');

    int length = items?.length ?? 0;

    return List.generate(length,
            (i) => Item(id: items![i][_itemColID],
                name: items[i][_itemColName],
                description: items[i][_itemColDescription],));
  }

  Future<List<Item>> searchForItems({String searchTerm = ''}) async{
    final database = await instance.database;

    List<Map<String, dynamic>>? items = await database?.query(_itemsTableName, where: '$_itemColName LIKE ?',whereArgs: ['%$searchTerm%']);

    int length = items?.length ?? 0;

    return List.generate(length,
            (i) => Item(id: items![i][_itemColID],
          name: items[i][_itemColName],
          description: items[i][_itemColDescription],),);
  }


  //other operations
}
