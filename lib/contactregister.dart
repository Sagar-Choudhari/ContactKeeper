import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logreg/data_models/user.dart';
import 'package:logreg/data_models/contact.dart';
import 'package:logreg/databasehelper/dbhelper.dart';
import 'package:logreg/main.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:sqflite/sqflite.dart';


class ContactRegister extends StatefulWidget {
  ContactRegister({Key? key}) : super(key: key);
  @override
  _ContactRegisterState createState() => _ContactRegisterState();
}

class _ContactRegisterState extends State<ContactRegister> {
  final dbHelper = DatabaseHelper.instance;
  final List<Contact> users = [];
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
    _data = await dbHelper.queryAllContact();
    setState(() {});
    return _data;
  }

  void _delete(id) async {
    var ret = await dbHelper.deleteContact(id);
    debugPrint('Deleted = $ret');
    _getData();
    // _showMessageInScaffold('deleted $rowsDeleted row(s): row $id');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(1),
          child: _data == null
              ? const Center(child: CircularProgressIndicator())
              : Scrollbar(
              isAlwaysShown: true,
              thickness: 7,
              radius: const Radius.circular(4),
              scrollbarOrientation: ScrollbarOrientation.left,
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
        '[${_data[index]['id']?.toInt()}] = ${_data[index]['user']} = ${_data[index]['name']} - ${_data[index]['contact']} - ${_data[index]['address']}',
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
}
