import 'dart:io';
import 'package:mazadatkom/DBs/Auction_Model.dart';
import 'package:mazadatkom/DBs/Item_Model.dart';
import 'package:mazadatkom/DBs/UserItem_Model.dart';
import 'package:mazadatkom/DBs/User_Model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'Buyer_Model.dart';

class DataBaseHelper {
  static const _databaseName = 'mainDatabase.db';
  static const _databaseVersion = 1;

  //Items table variables
  static const _itemsTableName = 'Items';
  static const _itemColID = 'id';
  static const _itemColName = 'name';
  static const _itemColDescription = 'description';
  static const _itemColCategory = 'category';

  //Auction table variables
  static const _auctionTableName = 'Auctions';
  static const _auctionColID = 'id';
  static const _auctionColStartPrice = 'start_price';
  static const _auctionColMinBid = 'min_bid';
  static const _auctionColIsActive = 'is_active';
  static const _auctionColDate = 'date';
  static const _auctionColTime = 'time';
  static const _auctionColImage = 'image';

  //User table variables
  static const _userTableName = 'Users';
  static const _userColID = 'id';
  static const _userColName = 'name';
  static const _userColEmail = 'email';
  static const _userColPass = 'pass';
  static const _userColContactInfo = 'info';

  //User's Items Table
  static const _userItemTableName = 'UsersItems';
  static const _userItemColUserID = 'user_id';
  static const _userItemColItemID = 'item_id';

  //Buyers Tables
  static const _buyerTableName = 'buyers';
  static const _buyerColUserID = 'buyer_id';
  static const _buyerColItemID = 'item_id';
  static const _buyerBeenBought = 'been_bought';

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
    $_itemColDescription TEXT NOT NULL,
    $_itemColCategory TEXT NOT NULL
    )
    ''');

    //Create auctions table
    await database.execute('''
    CREATE TABLE $_auctionTableName(
    $_auctionColID INT NOT NULL,
    $_auctionColMinBid INT NOT NULL,
    $_auctionColStartPrice INT NOT NULL,
    $_auctionColIsActive INT NOT NULL,
    $_auctionColDate TEXT NOT NULL,
    $_auctionColTime TEXT NOT NULL,
    $_auctionColImage TEXT NOT NULL,
    FOREIGN KEY($_auctionColID) REFERENCES $_itemsTableName($_itemColID)
    )
    ''');

    await database.execute('''
    CREATE TABLE $_userTableName(
    $_userColID INT PRIMARY KEY NOT NULL,
    $_userColName TEXT NOT NULL,
    $_userColEmail TEXT NOT NULL,
    $_userColPass TEXT NOT NULL,
    $_userColContactInfo TEXT NOT NULL
    )
    ''');

    await database.execute('''
    CREATE TABLE $_userItemTableName(
    $_userItemColUserID INT NOT NULL,
    $_userItemColItemID INT NOT NULL,
    FOREIGN KEY($_userItemColUserID) REFERENCES $_userTableName($_userColID),
    FOREIGN KEY($_userItemColItemID) REFERENCES $_itemsTableName($_itemColID)
    )
    ''');

    await database.execute('''
    CREATE TABLE $_buyerTableName(
    $_buyerColUserID INT NOT NULL,
    $_buyerColItemID INT NOT NULL,
    $_buyerBeenBought INT NOT NULL,
    FOREIGN KEY($_buyerColUserID) REFERENCES $_userTableName($_userColID),
    FOREIGN KEY($_buyerColItemID) REFERENCES $_itemsTableName($_itemColID)
    )
    ''');
  }

  //Allow foreign keys
  static Future _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  //items table operations
  Future<Item> getItem(int id) async {
    Database? database = await DataBaseHelper.instance.database;

    List<Map<String, dynamic>> result = await database?.query(
          _itemsTableName,
          where: '$_itemColID = ?',
          whereArgs: [id],
        ) ??
        List.filled(0, {});
    Item item = Item.fromMap(result[0]);

    return item;
  }

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

  Future<void> deleteItem(int id) async {
    Database? database = await instance.database;

    await database?.execute(
      '''
    begin
    DELETE FROM $_itemsTableName WHERE $_itemColID = ?
    DELETE FROM $_auctionTableName WHERE $_auctionColID = ?
    DELETE FROM $_userItemTableName WHERE $_userItemColItemID = ?
    commit
    ''',
    );
  }

  Future<int> getItemsCount() async {
    Database? database = await instance.database;
    List<Map>? result = await database?.query(_itemsTableName);
    return result?.length ?? 0;
  }

  //auctions table operations
  Future<Auction> getAuction(int id) async {
    Database? database = await DataBaseHelper.instance.database;

    List<Map<String, dynamic>> result = await database?.query(
          _auctionTableName,
          where: '$_auctionColID = ?',
          whereArgs: [id],
        ) ??
        List.filled(0, {});
    Auction auction = Auction.fromMap(result[0]);

    return auction;
  }

  Future<void> insertAuction(Auction auction) async {
    Database? database = await instance.database;

    await database?.insert(_auctionTableName, auction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateAuction(Auction auction) async {
    Database? database = await instance.database;

    await database?.update(_auctionTableName, auction.toMap(),
        where: 'id = ?', whereArgs: [auction.id]);
  }

  Future<void> printItems() async {
    Database? database = await instance.database;

    //prints table rows
    (await database?.query(_itemsTableName, columns: [
      _itemColID,
      _itemColName,
      _itemColDescription,
      _itemColCategory
    ]))
        ?.forEach((row) {
      print(row);
    });
  }

  //users table operations
  Future<User> getUser(String name) async {
    Database? database = await DataBaseHelper.instance.database;

    List<Map<String, dynamic>> result = await database?.query(_userTableName,
            where: '$_userColName = ?', whereArgs: [name]) ??
        List.empty();

    User user = User.fromMap(result[0]);

    return user;
  }

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

  Future<int?> getUsersCount() async {
    Database? database = await instance.database;
    List<Map>? result = await database?.query(_userTableName);
    return result?.length;
  }

  Future<bool> validateSignUp(String? name, String? email) async {
    Database? database = await instance.database;

    //check if name is in use
    List<Map> nameResult = await database?.query(_userTableName,
            where: '$_userColName = ?', whereArgs: [name]) ??
        List.empty();
    if (nameResult.isNotEmpty) {
      return false;
    }

    //check if email is in use
    print('email exists');
    List<Map> emailResult = await database?.query(_userTableName,
            where: '$_userColEmail = ?', whereArgs: [email]) ??
        List.empty();
    if (emailResult.isNotEmpty) {
      return false;
    }

    //complete normally
    return true;
  }

  Future<bool> validateSignIn(String name, String pass) async {
    Database? database = await instance.database;

    //check if name is in use
    List<Map> nameResult = await database?.query(_userTableName,
            where: '$_userColName = ?', whereArgs: [name]) ??
        List.empty();
    if (nameResult.isEmpty) {
      print("user doesn't exist");
      return false;
    }
    //check password
    String realPass = nameResult[0][_userColPass] ?? '';

    if (pass != realPass) {
      print('wrong pass');
      return false;
    }

    //complete normally
    print("you signed in");
    return true;
  }

  Future<void> printUsers() async {
    Database? database = await instance.database;

    print('printing users');
    //prints table rows
    (await database?.query(_userTableName, columns: [
      _userColID,
      _userColName,
      _userColEmail,
      _userColPass,
      _userColContactInfo
    ]))
        ?.forEach((row) {
      print(row);
    });
  }

  Future<User> getUserByID(int userID) async {
    Database? database = await instance.database;

    List<Map<String, dynamic>>? result = await database?.query(
      _userTableName,
      where: '$_userColID = ?',
      whereArgs: [userID],
    );
    return User.fromMap(result![0]);
  }

  //items users table operations
  Future<void> insertUserItem(UserItem userItem) async {
    Database? database = await instance.database;
    await database?.insert(_userItemTableName, userItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteUserItem(UserItem userItem) async {
    Database? database = await instance.database;
    await database?.delete(_userItemTableName,
        where: '$_userItemColUserID = ?', whereArgs: [userItem.userID]);
  }

  //buyers items methods
  Future<void> updateUserItem(UserItem userItem) async {
    Database? database = await instance.database;
    await database?.update(_userItemTableName, userItem.toMap(),
        where: '$_userItemColUserID = ?', whereArgs: [userItem.userID]);
  }

  Future<void> insertBuyerItem(Buyer buyerItem) async {
    Database? database = await instance.database;
    await database?.insert(_buyerTableName, buyerItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteBuyerItem(Buyer buyerItem) async {
    Database? database = await instance.database;
    await database?.delete(_buyerTableName,
        where: '$_buyerColItemID = ?', whereArgs: [buyerItem.buyerID]);
  }

  Future<void> updateBuyerItem(Buyer buyerItem) async {
    Database? database = await instance.database;
    await database?.update(_buyerTableName, buyerItem.toMap(),
        where: '$_buyerColItemID = ?', whereArgs: [buyerItem.itemID]);
  }

  Future<bool> checkBuyerAndItem(int itemID) async {
    Database? database = await instance.database;

    List<Map>? result = await database?.query(
      _buyerTableName,
      where: '$_buyerColItemID = ?',
      whereArgs: [
        itemID,
      ],
    );

    int length = result?.length ?? 0;
    if (length == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkBought(int itemID) async {
    Database? database = await instance.database;

    List<Map>? result = await database?.query(
      _buyerTableName,
      where: '$_buyerColItemID = ? AND $_buyerBeenBought = ?',
      whereArgs: [
        itemID,
        1,
      ],
    );

    int length = result?.length ?? 0;

    if (length == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<Buyer?> getBuyer(int itemID) async {
    Database? database = await instance.database;

    List<Map<String, dynamic>>? result = await database?.query(
      _buyerTableName,
      where: '$_buyerColItemID = ?',
      whereArgs: [itemID],
    );

    if (result?.isEmpty ?? true) {
      return null;
    }

    return Buyer.fromMap(result![0]);
  }

  Future<List<Buyer>> getBuyersItems(int id) async {
    Database? database = await instance.database;
    List<Map>? result = await database?.query(
      _buyerTableName,
      where: '$_buyerColUserID = ?',
      whereArgs: [id],
    );

    int length = result?.length ?? 0;

    return List.generate(
      length,
      (i) => Buyer(
        buyerID: result![i][_buyerColUserID],
        itemID: result[i][_buyerColItemID],
        beenBought: result[i][_buyerBeenBought],
      ),
    );
  }

  Future<void> printBuyers() async {
    Database? database = await instance.database;

    print('printing users');
    //prints table rows
    (await database?.query(
      _buyerTableName,
      columns: [_buyerColUserID, _buyerColItemID, _buyerBeenBought],
    ))
        ?.forEach((row) {
      print(row);
    });
  }

  Future<UserItem> getUserItem(int itemID) async {
    Database? database = await DataBaseHelper.instance.database;

    List<Map<String, dynamic>>? result = await database?.rawQuery('''
    SELECT *
    FROM $_userItemTableName
    WHERE $_userItemColItemID = ?
    ''', [
      itemID,
    ]);

    UserItem userItem = UserItem.fromMap(result![0]);
    return userItem;
  }

  Future<List<Item>> getUserItems({int? userID}) async {
    Database? database = await DataBaseHelper.instance.database;

    List<Map<String, dynamic>> queryResult = await database?.query(
            _userItemTableName,
            where: '$_userItemColUserID = ?',
            whereArgs: [userID]) ??
        List<Map<String, dynamic>>.empty();

    int length = queryResult.length;

    List<UserItem> userItems = List.generate(
      length,
      (i) => UserItem(
        itemID: queryResult[i][_userItemColItemID],
        userID: queryResult[i][_userItemColUserID],
      ),
    );

    List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.empty(growable: true);

    for (int i = 0; i < userItems.length; i++) {
      List<Map<String, dynamic>> x = await database?.query(
            _itemsTableName,
            where: '$_itemColID = ?',
            whereArgs: [userItems[i].itemID],
          ) ??
          List.empty();
      print(x[0]["id"]);
      items.add(x[0]);
    }

    int length1 = items.length;

    return List.generate(
      length1,
      (i) => Item(
        id: items[i][_itemColID],
        name: items[i][_itemColName],
        description: items[i][_itemColDescription],
        category: items[i][_itemColCategory],
      ),
    );
  }

  Future<List<Item>> getBuyerItems({int? userID}) async {
    Database? database = await DataBaseHelper.instance.database;

    List<Map<String, dynamic>> queryResult = await database?.query(
        _buyerTableName,
        where: '$_buyerBeenBought = ? AND $_buyerColUserID = ?',
        whereArgs: [1,userID]) ??
        List<Map<String, dynamic>>.empty();

    int length = queryResult.length;

    List<Buyer> buyerItems = List.generate(
      length,
          (i) => Buyer(
        itemID: queryResult[i][_buyerColItemID],
        buyerID: queryResult[i][_buyerColUserID],
            beenBought: queryResult[i][_buyerBeenBought]
      ),
    );

    List<Map<String, dynamic>> items =
    List<Map<String, dynamic>>.empty(growable: true);

    for (int i = 0; i < buyerItems.length; i++) {
      List<Map<String, dynamic>> x = await database?.query(
        _itemsTableName,
        where: '$_itemColID = ?',
        whereArgs: [buyerItems[i].itemID],
      ) ??
          List.empty();
      print(x[0]["id"]);
      items.add(x[0]);
    }

    int length1 = items.length;

    return List.generate(
      length1,
          (i) => Item(
        id: items[i][_itemColID],
        name: items[i][_itemColName],
        description: items[i][_itemColDescription],
        category: items[i][_itemColCategory],
      ),
    );
  }

  Future<void> printUserItems() async {
    Database? database = await instance.database;

    print('printing user items');
    //prints table rows
    (await database?.query(_userItemTableName,
            columns: [_userItemColItemID, _userItemColUserID]))
        ?.forEach((row) {
      print(row);
    });
  }

  //other operations
  Future<void> printAuctions() async {
    Database? database = await instance.database;

    //prints table rows
    (await database?.query(
      _auctionTableName,
      columns: [
        _auctionColID,
        _auctionColStartPrice,
        _auctionColMinBid,
        _auctionColIsActive,
        _auctionColDate,
        _auctionColTime,
      ],
    ))
        ?.forEach((row) {
      print(row);
    });
  }

  /*
  Future<void> clearTables() async {
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
  */

  //listview related operations
  Future<List<Item>> getItems() async {
    final database = await instance.database;

    List<Map<String, dynamic>>? items =
        await database?.query(_itemsTableName, orderBy: 'id DESC');

    int length = items?.length ?? 0;

    return List.generate(
        length,
        (i) => Item(
              id: items![i][_itemColID],
              name: items[i][_itemColName],
              description: items[i][_itemColDescription],
              category: items[i][_itemColCategory],
            ));
  }

  Future<List<Item>> searchForItems(
      {String searchterm = '', String category = 'None'}) async {
    final database = await instance.database;

    if (category != 'None') {
      List<Map<String, dynamic>>? itemsByCategory;
      try {
        print(category);
        itemsByCategory = await database?.rawQuery(
          '''
        select *
        from $_itemsTableName
        where 
        $_itemColCategory = ? 
        and 
        $_itemColName like ?
        ''',
          [category, '%$searchterm%'],
        );

        int len = itemsByCategory?.length ?? 0;

        if (len == 0) {
          print('no items found');
          return List<Item>.empty();
        }

        return List.generate(
          len,
          (i) => Item(
              id: itemsByCategory?[i][_itemColID],
              name: itemsByCategory?[i][_itemColName],
              description: itemsByCategory?[i][_itemColDescription],
              category: itemsByCategory?[i][_itemColCategory]),
        );
      } catch (e) {
        print(e.toString());
        itemsByCategory = List.empty();
      }
    }

    List<Map<String, dynamic>>? items = await database?.query(_itemsTableName,
        where: '$_itemColName LIKE ?', whereArgs: ['%$searchterm%']);

    int length = items?.length ?? 0;

    return List.generate(
      length,
      (i) => Item(
        id: items![i][_itemColID],
        name: items[i][_itemColName],
        description: items[i][_itemColDescription],
        category: items[i][_itemColCategory],
      ),
    );
  }

  //other operations
}
