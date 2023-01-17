import 'package:flutter/material.dart';

import 'main.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
              child: registerPageWidget()
          )
      ),
    );
  }
}

class registerPageWidget extends StatefulWidget {
  const registerPageWidget({Key? key}) : super(key: key);

  @override
  State<registerPageWidget> createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<registerPageWidget> {

  TextEditingController ipName = TextEditingController();
  TextEditingController ipEmail = TextEditingController();
  TextEditingController ipContact = TextEditingController();
  TextEditingController ipCity = TextEditingController();
  TextEditingController ipAddress = TextEditingController();
  TextEditingController ipPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Your Name',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contact',
                        hintText: 'Enter Your Contact',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        hintText: 'Enter Your City',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Enter Your Address',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Enter Password Again',
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: MaterialButton(
                        height: 55,
                        minWidth: 343.0,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () => {},
                        splashColor: Colors.redAccent,
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already have an account?'),
                      TextButton(
                        child: const Text(
                          'Sign-up',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          //register screen
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const MyApp();
                          }));
                        },
                      )
                    ],
                  ),
                ],
              )
          ),
        ]));
  }
}
