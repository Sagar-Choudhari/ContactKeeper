import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logreg/user.dart';
import 'package:logreg/dbhelper.dart';
import 'package:logreg/main.dart';
import 'package:flutter_session/flutter_session.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Dashboard'),
      ),
      body: const HomeWidget(),
      drawer: Drawer(
        child: drawerItems,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Add Contact',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// _snackBar(String text, Color colors) {
//   ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(text),
//         backgroundColor: colors,
//         action: SnackBarAction(
//           label: 'OK!',
//           onPressed: () {
//             // Some code to undo the change.
//           },
//         ),
//       )
//   );
// }

const drawerHeader = UserAccountsDrawerHeader(
  accountName: Text('Sagar'),
  accountEmail: Text('Sagar@123.com'),
  currentAccountPicture: CircleAvatar(
    backgroundColor: Colors.white,
    child: FlutterLogo(
      size: 42.0,
    ),
  ),
);

final drawerItems = ListView(

  children: <Widget>[
    drawerHeader,
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.short_text),
          Text('  NAME'),
        ],
      ),
      onTap: () {

      },
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.mail),
          Text('hjgkj'),
        ],
      ),
      onTap: () {

      },
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.call),
          Text('  CONTACT'),
        ],
      ),
      onTap: () {

      },
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.home_work_outlined),
          Text('  CITY'),
        ],
      ),
      onTap: () {

      },
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.maps_home_work),
          Text('  ADDRESS'),
        ],
      ),
      onTap: () {

      },
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.password),
          Text('  PASSWORD'),
        ],
      ),
      onTap: () {

      },
    ),
    ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.logout),
          Text('  Logout'),
        ],
      ),
      onTap: () async {
        var checkSession = await FlutterSession().get('loggedUser');
        // if(){
        //   const SnackBar snackBar =
        //   SnackBar(
        //     content: Text('Logged Out :('),
        //     backgroundColor: Colors.orange,
        //   );
        //   scaffoldKey.currentState?.showSnackBar(snackBar);
        //
        //
        // } else {
        //   const SnackBar snackBar =
        //   SnackBar(
        //     content: Text('Fail to Logout :)'),
        //     backgroundColor: Colors.green,
        //   );
        //   scaffoldKey.currentState?.showSnackBar(snackBar);
        // }
        _logout(checkSession);
      },
    )
  ],
);


final dbHelper = DatabaseHelper.instance;
Future<bool> _logout(email) async {
  await dbHelper.logout(email);
  return true;
}


TextEditingController _textFieldName = TextEditingController();
TextEditingController _textFieldContact = TextEditingController();
TextEditingController _textFieldAddress = TextEditingController();

bool _validate = false;

Future<void> _showDialog(BuildContext context) async {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: const Text("Add Contact"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              onChanged: (value) {},
              controller: _textFieldName,
              decoration: const InputDecoration(hintText: "Enter name"),
            ),
            TextField(
              onChanged: (value) {},
              controller: _textFieldContact,
              decoration: const InputDecoration(hintText: "Enter contact"),
            ),
            TextField(
              onChanged: (value) {},
              controller: _textFieldAddress,
              decoration: const InputDecoration(hintText: "Enter address"),
            ),
          ],
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
            onPressed: () {},
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

class HomeWidget extends StatefulWidget {

  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final dbHelper = DatabaseHelper.instance;
  final List<User> users = [];



  @override
  Widget build(BuildContext context) {
    const numItems = 20;

    Widget buildRow(int index) {
      return ListTile(
        leading: CircleAvatar(
          child: Text('$index'),
        ),
        title: Text(
          '[${users[index].id}] = ${users[index].status} = ${users[index].name} - ${users[index].email} - ${users[index].contact} - ${users[index].address}',
          style: const TextStyle(fontSize: 18),
        ),
        trailing: IconButton(
            onPressed: () {
              setState(() {
                _delete(users[index].id);
                _getData();
              });
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
            print('item tapped');
          });
          },
      );
    }

    // Widget _listView(){
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: users.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
          return ElevatedButton(
            child: const Text('Refresh'),
            onPressed: () {
              setState(() {
                _getData();
              });
            },
          );
        }
        return buildRow(index);
      }, separatorBuilder: (BuildContext context, int index) {
      return const Divider();
    },
    );
    // }
  }

  void _getData() async {
    final allRows = await dbHelper.queryAllRows();
    users.clear();
    for (var row in allRows) {
      users.add(User.fromMap(row));
    }
    // _showMessageInScaffold('Query done.');
    setState(() {});
  }


  void _delete(id) async {
    Text('$id deleted');
    await dbHelper.delete(id);
    // _showMessageInScaffold('deleted $rowsDeleted row(s): row $id');
  }
}


