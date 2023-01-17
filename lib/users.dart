import 'package:logreg/dbhelper.dart';

class Users {
  late int id;
  late String name;
  late String email;
  late String city;
  late String address;
  late String password;

  Users(this.id, this.name, this.email, this.city, this.address, this.password);

  Users.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    city = map['city'];
    address = map['address'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnEmail : email,
      DatabaseHelper.columnCity : city,
      DatabaseHelper.columnAddress : address,
      DatabaseHelper.columnPassword: password,
    };
  }
}