import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:logreg/contactregister.dart';
import 'package:logreg/user.dart';
import 'package:logreg/dbhelper.dart';
import 'package:logreg/register.dart';
import 'package:logreg/home.dart';
import 'package:logreg/userregister.dart';
import 'dart:ui' as ui;
import 'package:sqflite/sqflite.dart';

import 'getc.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldKey =
GlobalKey<ScaffoldMessengerState>();

void main() {
  // RenderErrorBox.backgroundColor = Colors.transparent;
  // RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  runApp(MyApp());
}
class Value {
  static String value = '';
  static void setString(String newValue) {
    value = newValue;
  }

  static String getString() {
    return value;
  }
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  static const String _title = 'LoggerAppVITPL';




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() {
    return new _MyStatefulWidgetState();
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _validateEmail = false;
  bool _validatePassword = false;

  final dbHelper = DatabaseHelper.instance;
  final List<User> users = [];

  // late var loggerDetail;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                errorText: _validateEmail ? 'Enter email & in proper format!' : null,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                errorText: _validatePassword ? 'Password cannot be empty' : null,
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: const Text(
          //     'Forgot Password',
          //   ),
          // ),
          Container(
              height: 70,
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: ElevatedButton(
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  if (emailController.text.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(emailController.text)) {
                    setState(() {
                      _validateEmail = true;
                    });
                  } else {
                    setState(() {
                      _validateEmail = false;
                    });
                  }
                  setState(() {
                    passwordController.text.isEmpty
                        ? _validatePassword = true
                        : _validatePassword = false;
                  });
                  if(await checkLogin(emailController.text,passwordController.text)){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_context) => HomePage()));
                    _snackBar('Login Success :)');
                  } else {
                    _snackBar('fail!!!');
                  }
                  Value.setString(emailController.text);
                  setState(() {
                    _isLoading=false;
                  });
                },
              )
          ),
          // Container(
          //   padding: const EdgeInsets.all(50),
          //   margin:const EdgeInsets.all(50) ,
          //   color: Colors.blue[100],
          //   //widget shown according to the state
          //   child: Center(
          //     child: !_isLoading
          //         ?const Text("Loading Complete")
          //         :const CircularProgressIndicator(),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Does not have account?'),
              TextButton(
                child: const Text(
                  'Sign-in',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //register screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage(title: 'RegisterPage');
                  }));
                },
              )
            ],
          ),
          TextButton(
            child: const Text(
              'GO TO HOME',
              style: TextStyle(fontSize: 15, color: Colors.indigo),
            ),
            onPressed: () async {
              var checkSession = await FlutterSession().get('loggedUser');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            },
          ),
          TextButton(
            child: const Text(
              'User REGISTER',
              style: TextStyle(fontSize: 15, color: Colors.indigo),
            ),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserRegister();
              }));
            },
          ),
          TextButton(
            child: const Text(
              'Contact REGISTER',
              style: TextStyle(fontSize: 15, color: Colors.indigo),
            ),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContactRegister();
              }));
            },
          ),
          Container(
            height: 20,
            child: Text(Value.getString()+' <- ID'),
          ),
          Container(
            height: 20,
            // child: Text('getSession'),
          ),
        ],
      ),
    );
  }

  Future<void> getSession() async {
    var seas = await FlutterSession().get('loggedUser');
    print(seas);
  }



  _snackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          action: SnackBarAction(
            label: 'OK!',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        )
    );
  }

  Future<bool> checkLogin(String email, String password) async {

    var result = await dbHelper.login(email, password);

    // Text( '${users[index].email} - ${users[index].password}');

    if(result){
      return true;
    } else {
      return false;
    }
  }

}
