import 'package:flutter/material.dart';
import 'package:logreg/data_models/user.dart';
import 'package:logreg/data_models/contact.dart';
import 'package:logreg/databasehelper/dbhelper.dart';
import 'package:logreg/main.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  final List<User> users = [];
  static List<Map> _data = [];
  final List<Contact> contacts = [];
  static List<Map> _contacts = [];

  bool _isLoading = false;
  var checkSession;

  var currentUser = Value.getString();

  @override
  initState() {
    super.initState();
    if (currentUser == 'null') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('LOGIN WITH CREDENTIAL!!'),
        backgroundColor: Colors.redAccent,
      ));
    }
    dbHelper.database;
    _getData2(Value.getString());
    _getData(currentUser);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("WIDGET LOADED VRO == ${Value.getString()}");
      if (_data.isEmpty) {
        debugPrint('LIST IS EMPTYYYYYYYY');
      }
      checkSession = await FlutterSession().get('loggedUser');
    });
  }

  _getData(appUser) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      Database db = await openDatabase("users.db");
      _contacts = await db.query(DatabaseHelper.tableContact,
          columns: ['id', 'user', 'name', 'contact', 'address'],
          where: 'user = ?',
          whereArgs: [appUser]);
      setState(() {});
      return _contacts;
    });
  }

  Future<List<Map>> _getData2(email) async {
    Database db = await openDatabase("users.db");
    _data = await db.query(DatabaseHelper.table,
        columns: ['name', 'email', 'contact', 'city', 'address', 'password'],
        where: 'email = ?',
        whereArgs: [email]);
    return _data;
  }

  Future _logout(email) async {
    await dbHelper.logout(email);
    debugPrint('Logged Out Function');
    Value.setString('null');

    // Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    // Navigator.pushReplacement<void, void>(
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => const MyApp(),
    //   ),
    // );
  }

  Future _delete(id) async {
    var ret = await dbHelper.deleteContact(id);
    debugPrint('Deleted = $ret');
    _getData(currentUser);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                _data[0]['name'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text('${_data[0]['email']}'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: FlutterLogo(
                  size: 42.0,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.person),
                  Container(
                    width: 15,
                  ),
                  Text(_data[0]['name']),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.mail),
                  Container(
                    width: 15,
                  ),
                  Text(_data[0]['email']),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.call),
                  Container(
                    width: 15,
                  ),
                  Text(_data[0]['contact']),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.add_business),
                  Container(
                    width: 15,
                  ),
                  Text(_data[0]['city']),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.home_work_outlined),
                  Container(
                    width: 15,
                  ),
                  Text(_data[0]['address']),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.password),
                  Container(
                    width: 15,
                  ),
                  Text(_data[0]['password']),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.logout),
                  Container(
                    width: 15,
                  ),
                  const Text('Logout'),
                ],
              ),
              onTap: () {
                _logout(checkSession);

                Navigator.of(context, rootNavigator: true).pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Logged Out :('),
                  backgroundColor: Colors.red,
                ));
                debugPrint('LOGGED OUT');
                Navigator.of(context).maybePop();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Add Contact',
        child: const Icon(Icons.add),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: _contacts == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    child: _contacts.isEmpty
                        ? const Text(
                            "No Contacts.",
                            textAlign: TextAlign.center,
                          )
                        : Column(
                            children: _contacts.map((contacts) {
                              return Card(
                                  elevation: 5,
                                  color: Colors.white70,
                                  child: ListTile(
                                      leading: const Icon(
                                          Icons.perm_contact_calendar),
                                      title: Text(
                                          '${contacts['name']} + ${contacts['user']}'),
                                      subtitle: Text(
                                          "ID:${contacts['id']}, Con: ${contacts['contact']}, Add: ${contacts['address']}"),
                                      trailing: IconButton(
                                          onPressed: () {
                                            // await dbHelper.deleteContact(contacts["id"]);
                                            _delete(contacts['id']);
                                            debugPrint("Data Deleted");
                                            _getData(currentUser);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    action: SnackBarAction(
                                                      label: 'OK!',
                                                      onPressed: () {},
                                                    ),
                                                    content: const Text(
                                                        "Contact Data Deleted")));
                                            _getData(currentUser);
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red))));
                            }).toList(),
                          ),
                  ),
                )),
    );
  }

  final TextEditingController _textFieldName = TextEditingController();
  final TextEditingController _textFieldContact = TextEditingController();
  final TextEditingController _textFieldAddress = TextEditingController();

  bool _diaNameValidate = false;
  bool _diaContactValidate = false;
  bool _diaAddressValidate = false;

  @override
  void dispose() {
    _textFieldName.dispose();
    _textFieldContact.dispose();
    _textFieldAddress.dispose();
    super.dispose();
  }

  Future<void> _showDialog(BuildContext context) async {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Add Contact"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Container(
            width: 345,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  onChanged: (value) {},
                  controller: _textFieldName,
                  maxLength: 25,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: "Enter name",
                    icon: const Icon(Icons.perm_contact_cal),
                    errorText: _diaNameValidate ? 'Name cannot be empty' : null,
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {},
                  controller: _textFieldContact,
                  keyboardType: TextInputType.phone,
                  maxLength: 12,
                  decoration: InputDecoration(
                    hintText: "Enter contact",
                    icon: const Icon(Icons.call),
                    labelText: 'Contact',
                    errorText:
                        _diaContactValidate ? 'Contact cannot be empty' : null,
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {},
                  controller: _textFieldAddress,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: "Enter address",
                    labelText: 'Address',
                    icon: const Icon(Icons.home_work_outlined),
                    errorText:
                        _diaAddressValidate ? 'Address cannot be empty' : null,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
              ),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textFieldName.text.isEmpty ||
                    !RegExp(r'^[a-z A-Z]+$').hasMatch(_textFieldName.text)) {
                  setState(() => _diaNameValidate = true);
                } else {
                  setState(() => _diaNameValidate = false);
                }
                if (_textFieldContact.text.isEmpty ||
                    !RegExp(r'^(\+\d{1,3}[- ]?)?\d{10}$')
                        .hasMatch(_textFieldContact.text)) {
                  setState(() => _diaContactValidate = true);
                } else {
                  setState(() => _diaContactValidate = false);
                }
                setState(() {
                  _textFieldAddress.text.isEmpty
                      ? _diaAddressValidate = true
                      : _diaAddressValidate = false;
                });
                String name = _textFieldName.text;
                String contact = _textFieldContact.text;
                String address = _textFieldAddress.text;
                _insertContact(currentUser, name, contact, address);
                _getData(currentUser);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  void _insertContact(user, name, contact, address) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.contactUser: user,
      DatabaseHelper.contactName: name,
      DatabaseHelper.contactContact: contact,
      DatabaseHelper.contactAddress: address,
    };
    Contact contacts = Contact.fromMap(row);
    final id = await dbHelper.insertContact(contacts);
    debugPrint('inserted row id: $id \n');
    debugPrint('Data Inserted :)');
  }
}
