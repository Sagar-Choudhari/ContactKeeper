import 'package:logreg/data_models/user.dart';
import 'package:logreg/data_models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_session/flutter_session.dart';


class DatabaseHelper {

  static const _databaseName = "users.db";
  static const _databaseVersion = 1;

  static const table = 'users_table';
  static const tableContact = 'contact_table';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnContact = 'contact';
  static const columnCity = 'city';
  static const columnAddress = 'address';
  static const columnPassword = 'password';
  static const columnStatus = 'status';

  static const contactId = 'id';
  static const contactUser = 'user';
  static const contactName = 'name';
  static const contactContact = 'contact';
  static const contactAddress = 'address';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

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

  _initDatabase() async{
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
    version: _databaseVersion,
    onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table ( 
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnContact TEXT NOT NULL,
            $columnCity TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnStatus TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableContact ( 
            $contactId INTEGER PRIMARY KEY AUTOINCREMENT,
            $contactUser TEXT NOT NULL,
            $contactName TEXT NOT NULL,
            $contactContact TEXT NOT NULL,
            $contactAddress TEXT NOT NULL 
          )
          ''');
  }


  Future<int> insert(User users) async {
    Database db = await instance.database;
    return await db.insert(table,
        {
          'name': users.name,
          'email': users.email,
          'contact': users.contact,
          'city': users.city,
          'address': users.address,
          'password': users.password,
          'status': users.status
        });
  }

  Future<int> insertContact(Contact contacts) async {
    Database db = await instance.database;
    return await db.insert(tableContact,
        {
          'user': contacts.user,
          'name': contacts.name,
          'contact': contacts.contact,
          'address': contacts.address
        });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllContact() async {
    Database db = await instance.database;
    return await db.query(tableContact);
  }

  Future<List<Map>> getOnlyMatchedContact(email) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(tableContact,
        columns: ['name', 'contact','address'],
        where: 'user = ?',
        whereArgs: [email]);
    return maps;
  }

  Future<List<Map>> getLoggerDetails(email) async {
    Database db = await instance.database;

    List<Map> maps = await db.query(table,
        columns: ['name','email','contact','city','address','password'],
        where: 'email = ?',
        whereArgs: [email]);
    return maps;
  }

  Future<bool> login(email,password) async {
    Database db = await instance.database;
    // return await db.query(table, where: "$columnEmail LIKE '%$email%'");

    List<Map> maps = await db.query(table,
        columns: ['email', 'password'],
        where: 'email = ?',
        whereArgs: [email]);

    if (maps.isNotEmpty && maps[0]['password'] == password) {
      db.update(table, {'status': 'logged_in'}, where: 'email = ?', whereArgs: [email]);
      await FlutterSession().set('loggedUser',email);
      return true;
    } else {
      return false;
    }
  }

  _getData() async {
    Database db = await openDatabase('users.db');
    List<Map> _data = await db.query('users_table');
    return;
  }

  Future<bool> logout(String email) async {

    Database db = await instance.database;

    int result = await db.update(table, {'status': 'logged_out'}, where: 'email = ?', whereArgs: [email]);
    await FlutterSession().set('loggedUser',null);
    if (result > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(User users) async {
    Database db = await instance.database;
    int id = users.toMap()['id'];
    return await db.update(table, users.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteContact(user) async {
    Database db = await instance.database;
    return await db.delete(tableContact,
        where: '$contactId = ?',
        whereArgs: [user]
    );
  }
}