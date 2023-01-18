import 'dart:io';

import 'package:flutter/material.dart';

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
      onTap: () {},
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.mail),
          Text('  EMAIL'),
        ],
      ),
      onTap: () {},
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.call),
          Text('  CONTACT'),
        ],
      ),
      onTap: () {},
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.home_work_outlined),
          Text('  CITY'),
        ],
      ),
      onTap: () {},
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.maps_home_work),
          Text('  ADDRESS'),
        ],
      ),
      onTap: () {},
    ),
    ListTile(
      title: Row(
        children: const [
          Icon(Icons.password),
          Text('  PASSWORD'),
        ],
      ),
      onTap: () {},
    ),
    ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.arrow_back_rounded),
          Text('  Go Back'),
        ],
      ),
      onTap: () {

      },
    ),
    ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.exit_to_app),
          Text('  Exit'),
        ],
      ),
      onTap: () => exit(0),
    )
  ],
);


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
  @override
  Widget build(BuildContext context) {
    const numItems = 20;

    Widget buildRow(int index) {
      return ListTile(
        leading: CircleAvatar(
          child: Text('$index'),
        ),
        title: Text(
          'Text $index',
        ),
        trailing: const Icon(Icons.dashboard_customize_outlined),
      );
    }

    // Widget _listView(){
    return ListView.builder(
      itemCount: numItems * 2,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2 + 1;
        return buildRow(index);
      },
    );
    // }
  }
}
