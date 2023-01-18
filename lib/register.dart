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
              constraints: const BoxConstraints(),
              child: const registerPageWidget())),
    );
  }
}

class registerPageWidget extends StatefulWidget {
  const registerPageWidget({Key? key}) : super(key: key);

  @override
  State<registerPageWidget> createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<registerPageWidget> {
  final TextEditingController _ipName = TextEditingController();
  final TextEditingController _ipEmail = TextEditingController();
  final TextEditingController _ipContact = TextEditingController();
  final TextEditingController _ipCity = TextEditingController();
  final TextEditingController _ipAddress = TextEditingController();
  final TextEditingController _ipPassword = TextEditingController();
  final TextEditingController _ipPassword2 = TextEditingController();

  bool _nameValidate = false;
  bool _emailValidate = false;
  bool _contactValidate = false;
  bool _cityValidate = false;
  bool _addressValidate = false;
  bool _passwordValidate = false;
  bool _password2Validate = false;

  @override
  void dispose() {
    _ipName.dispose();
    _ipEmail.dispose();
    _ipContact.dispose();
    _ipCity.dispose();
    _ipAddress.dispose();
    _ipPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Your Name',
                        errorText:
                            _nameValidate ? 'Name cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        errorText:
                            _emailValidate ? 'Email cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipContact,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contact',
                        hintText: 'Enter Your Contact',
                        errorText:
                            _contactValidate ? 'Contact cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipCity,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        hintText: 'Enter Your City',
                        errorText:
                            _cityValidate ? 'City cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Enter Your Address',
                        errorText:
                            _addressValidate ? 'Address cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        errorText: _passwordValidate
                            ? 'Password cannot be empty'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipPassword2,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Enter Password Again',
                        errorText: _password2Validate
                            ? 'Password cannot be empty'
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: MaterialButton(
                      height: 55,
                      minWidth: 343.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () => {
                        if (_ipName.text.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(_ipName.text))
                          {
                            setState(() {
                              _nameValidate = true;
                            })
                          }
                        else
                          {
                            setState(() {
                              _nameValidate = false;
                            })
                          },
                        if (_ipEmail.text.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(_ipEmail.text))
                          {
                            setState(() {
                              _emailValidate = true;
                            })
                          }
                        else
                          {
                            setState(() {
                              _emailValidate = false;
                            })
                          },
                        if (_ipContact.text.isEmpty ||
                            !RegExp(r'^(\+\d{1,3}[- ]?)?\d{10}$')
                                .hasMatch(_ipContact.text))
                          {
                            setState(() {
                              _contactValidate = true;
                            })
                          }
                        else
                          {
                            setState(() {
                              _contactValidate = false;
                            })
                          },
                        setState(() {
                          _ipPassword.text.isEmpty
                              ? _passwordValidate = true
                              : _passwordValidate = false;
                          _ipPassword2.text.isEmpty
                              ? _password2Validate = true
                              : _password2Validate = false;
                          _ipCity.text.isEmpty
                              ? _cityValidate = true
                              : _cityValidate = false;
                          _ipAddress.text.isEmpty
                              ? _addressValidate = true
                              : _addressValidate = false;
                        })
                      },
                      splashColor: Colors.redAccent,
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(fontSize: 20),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const MyApp();
                          }));
                        },
                      )
                    ],
                  ),
                ],
              )),
        ]));
  }
}
