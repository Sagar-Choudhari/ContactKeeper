import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logreg/user.dart';
import 'package:logreg/dbhelper.dart';
import 'package:logreg/main.dart';



class UserRegister extends StatefulWidget {
  UserRegister({Key? key}) : super(key: key);
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final dbHelper = DatabaseHelper.instance;
  final List<User> users = [];
  static List<Map> _data = [];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("WIDGET LOADED VRO == ${Value.getString()}");
    });
    _getData();
  }

  Future<List<Map>> _getData() async {
    _data = await dbHelper.queryAllRows();
    setState(() {});
    return _data;
  }

  void _delete(id) async {
    Text('$id deleted');
    var ret = await dbHelper.delete(id);
    debugPrint('Deleted = $ret');
    _getData();
    // _showMessageInScaffold('deleted $rowsDeleted row(s): row $id');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Users'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Add Contact',
        child: const Icon(Icons.add),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(1),
          child: _data == null
              ? const Center(child: CircularProgressIndicator())
              : Scrollbar(
              isAlwaysShown: true, //always show scrollbar
              thickness: 7, //width of scrollbar
              radius: const Radius.circular(4), //corner radius of scrollbar
              scrollbarOrientation: ScrollbarOrientation.left, //which side to show scrollbar
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: _data.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildRow(index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )
          )
      ),
    );
  }
  Widget buildRow(int index) {
    final item = _data[index]['id'];
    return ListTile(
      leading: CircleAvatar(
        child: Text('$index'),
      ),
      title: Text(
        '[${_data[index]['id']?.toInt()}] = ${_data[index]['status']} = ${_data[index]['name']} - ${_data[index]['email']} - ${_data[index]['contact']} - ${_data[index]['city']} - ${_data[index]['address']} - ${_data[index]['password']}',
        style: const TextStyle(fontSize: 18),
      ),
      trailing: IconButton(
          onPressed: () {
            _delete(_data[index]['id']);
            _getData();
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
            size: 26,
          )
      ),
      selected: true,
      onTap: () {
        setState(() {
          if (kDebugMode) {
            print('item tapped');
          }
        });
      },
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
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(10.0)),
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
                    errorText:
                    _diaNameValidate ? 'Name cannot be empty' : null,
                  ),
                ),
                Container(height: 10,),
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
                Container(height: 10,),
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
                    !RegExp(r'^[a-z A-Z]+$').hasMatch(_textFieldName.text))
                {
                  setState(() => _diaNameValidate = true );
                }
                else
                {
                  setState(() => _diaNameValidate = false );
                }
                if (_textFieldContact.text.isEmpty ||
                    !RegExp(r'^(\+\d{1,3}[- ]?)?\d{10}$')
                        .hasMatch(_textFieldContact.text))
                {
                  setState(() => _diaContactValidate = true );
                }
                else
                {
                  setState(() => _diaContactValidate = false );
                }
                setState(() {
                  _textFieldAddress.text.isEmpty
                      ? _diaAddressValidate = true
                      : _diaAddressValidate = false;
                });
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
}
