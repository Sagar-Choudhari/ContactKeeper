import 'package:flutter/material.dart';
import 'package:logreg/databasehelper/dbhelper.dart';
import 'package:logreg/data_models/user.dart';

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
  final dbHelper = DatabaseHelper.instance;

  final List<User> users = [];

  //controllers used in insert operation UI
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

  bool showPassword = false;
  bool showPassword2 = false;

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

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  OnPasswordChanged(String password) {
    setState(() {
      _password2Validate = false;
      if (password == _ipPassword2.text) {
        _password2Validate = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipName,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Your Name',
                        errorText:
                            _nameValidate ? 'Name cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipEmail,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        errorText:
                            _emailValidate ? 'Email cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipContact,
                      maxLength: 12,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Contact',
                        hintText: 'Enter Your Contact',
                        errorText:
                            _contactValidate ? 'Contact cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipCity,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'City',
                        hintText: 'Enter Your City',
                        errorText:
                            _cityValidate ? 'City cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Enter Your Address',
                        errorText:
                            _addressValidate ? 'Address cannot be empty' : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipPassword,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        errorText: _passwordValidate
                            ? 'Password cannot be empty'
                            : null,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xff0094ff)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _ipPassword2,
                      obscureText: !showPassword2,
                      onChanged: (confirmPassword) =>
                          OnPasswordChanged(_ipPassword2.text),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Enter Password Again',
                        errorText: _password2Validate
                            ? 'Password cannot be empty'
                            : null,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showPassword2 = !showPassword2;
                            });
                          },
                          child: Icon(
                              showPassword2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xff0094ff)),
                        ),
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
                      splashColor: Colors.redAccent,
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_ipName.text.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(_ipName.text)) {
                          setState(() {
                            _nameValidate = true;
                          });
                        } else {
                          setState(() {
                            _nameValidate = false;
                          });
                        }
                        if (_ipEmail.text.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(_ipEmail.text)) {
                          setState(() {
                            _emailValidate = true;
                          });
                        } else {
                          setState(() {
                            _emailValidate = false;
                          });
                        }
                        if (_ipContact.text.isEmpty ||
                            !RegExp(r'^(\+\d{1,3}[- ]?)?\d{10}$')
                                .hasMatch(_ipContact.text)) {
                          setState(() {
                            _contactValidate = true;
                          });
                        } else {
                          setState(() {
                            _contactValidate = false;
                          });
                        }
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
                        });
                        String name = _ipName.text;
                        String email = _ipEmail.text;
                        String contact = _ipContact.text;
                        String city = _ipCity.text;
                        String address = _ipAddress.text;
                        String password = _ipPassword.text;
                        String status = 'logged_out';

                        if (_ipName.text.isEmpty ||
                            _ipEmail.text.isEmpty ||
                            _ipContact.text.isEmpty ||
                            _ipCity.text.isEmpty ||
                            _ipAddress.text.isEmpty ||
                            _ipPassword.text.isEmpty ||
                            _ipPassword2.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Filed can not be empty??'),
                            backgroundColor: Colors.deepOrangeAccent,
                            action: SnackBarAction(
                              label: 'OK!',
                              onPressed: () {},
                            ),
                          ));
                        } else {
                          if (_nameValidate ||
                              _emailValidate ||
                              _contactValidate ||
                              _passwordValidate ||
                              _cityValidate ||
                              _addressValidate ||
                              _password2Validate) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Please enter valid data!!'),
                              backgroundColor: Colors.lime,
                              action: SnackBarAction(
                                label: 'OK!',
                                onPressed: () {},
                              ),
                            ));
                          } else {
                            if (_ipPassword.text != _ipPassword2.text) {
                              _passwordValidate = false;
                              _password2Validate = false;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: const Text('Password not matched!!'),
                                action: SnackBarAction(
                                  label: 'OK!',
                                  onPressed: () {},
                                ),
                              ));
                            } else {
                              _insert(name, email, contact, city, address,
                                  password, status);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text('Registered Successfully :)'),
                                backgroundColor: Colors.green,
                                action: SnackBarAction(
                                  label: 'OK!',
                                  onPressed: () {},
                                ),
                              ));
                            }
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already have an account?'),
                      TextButton(
                        child: const Text(
                          'Sign-up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop(context);
                        },
                      )
                    ],
                  ),
                ],
              )),
        ]));
  }

  void _insert(name, email, contact, city, address, password, status) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnContact: contact,
      DatabaseHelper.columnCity: city,
      DatabaseHelper.columnAddress: address,
      DatabaseHelper.columnPassword: password,
      DatabaseHelper.columnStatus: status,
    };
    User user = User.fromMap(row);
    final id = await dbHelper.insert(user);
    _showMessageInScaffold('inserted row id: $id');
    debugPrint('Data Inserted :)');
  }
}
