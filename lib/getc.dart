import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logreg/dbhelper.dart';
import 'package:logreg/home.dart';

class ListContacts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ListContacts();
  }
}

class _ListContacts extends State<ListContacts>{

  List<Map> slist = [];
  DatabaseHelper mydb = DatabaseHelper.instance;

  @override
  void initState() {
    mydb.database;
    getdata();
    super.initState();
  }

  getdata(){
    Future.delayed(Duration(milliseconds: 500),() async {
      //use delay min 500 ms, because database takes time to initilize.
      slist = await mydb.queryAllRows();

      setState(() { }); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Contacts"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.length == 0 ? Text("No any contacts to show."): //show message if there is no any student
          Column(  //or populate list to Column children if there is student data.
            children: slist.map((contacts){
              return Card(
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text(contacts["name"]),
                  subtitle: Text("Contact:${contacts["contact"]}, Add: " + contacts["address"]),
                  trailing: Wrap(children: [

                    IconButton(onPressed: () async {
                      // await mydb.db.rawDelete("DELETE FROM students WHERE roll_no = ?", [stuone["roll_no"]]);
                      await mydb.deleteContact(contacts["id"]);

                      //delete student data with roll no.
                      print("Data Deleted");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" Data Deleted")));
                      getdata();
                    }, icon: Icon(Icons.delete, color:Colors.red))

                  ],),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}