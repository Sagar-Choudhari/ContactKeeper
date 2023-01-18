import 'package:logreg/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static const _databaseName = "users.db";
  static const _databaseVersion = 1;

  static const table = 'users_table';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnContact = 'contact';
  static const columnCity = 'city';
  static const columnAddress = 'address';
  static const columnPassword = 'password';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //
  //   // lazily instantiate the db the first time it is accessed
  //   _database = await _initDatabase();
  //   return _database;
  // }

  Future<Database> get database async {
    return _database ??= await _initDatabase();
}

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async{
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
    version: _databaseVersion,
    onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table ( 
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnContact TEXT NOT NULL,
            $columnCity TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insert(User users) async {
    Database db = await instance.database;
    return await db.insert(table, {'name': users.name, 'email': users.email, 'contact': users.contact, 'city': users.city, 'address': users.address, 'password': users.password});
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received


  Future<List<Map<String, dynamic>>> login(email) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnEmail LIKE '%$email%'");
  }


  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(User users) async {
    Database db = await instance.database;
    int id = users.toMap()['id'];
    return await db.update(table, users.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}