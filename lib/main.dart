import 'package:flutter/material.dart';
import 'package:logreg/register.dart';
import 'package:logreg/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'LoggerAppVITPL';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
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
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class PersonData {
  String email = '';
  String password = '';
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              controller: usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
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
                onPressed: () {},
              )
          ),
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomePage(title: 'HomePage');
              }));
            },
          )
        ],
      ),
    );
  }
}
