import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _databaseName = 'mainDatabase.db';
  static final _databaseVersion = 1;
  static final _tableNames = [
    'Items',
  ];

  //singlton
  DBHelper._constructDB();
  static final DBHelper instance = DBHelper._constructDB();

  static late Database _database;

  //get the databse
  Future<Database> get database async {
    //check if null
    if (_database != null) return _database;

    //if NULL initialize
    _database = await _initiateDB();
    return _database;
  }

  //initialize the datbase
  _initiateDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
    CREATE TABLE ${_tableNames[0]}(
    id INT PRIMARY KEY AUTOINCREMENT
    name TEXT NOT NULL
    )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database database = await instance.database;
    return await database.insert(_tableNames[0], row);
  }

  Future<List<Map<String, dynamic>>> ReturnAll() async{
    Database database = await instance.database;
    return await database.query(_databaseName[0]);
  }

  Future<int> Update(Map<String,dynamic> row) async{
    Database database = await instance.database;
    String name = row['id'];
    return await database.update(_databaseName[0], row, where: 'name = ? ' , whereArgs: [name]);
  }

  Future Delete(int id) async{
    Database database = await instance.database;
    return  await database.delete(_databaseName[0] , where: 'id' , whereArgs: [id]);
  }
}
