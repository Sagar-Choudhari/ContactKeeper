import 'package:logreg/dbhelper.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? contact;
  String? city;
  String? address;
  String? password;

  User(this.id, this.name, this.email, this.contact, this.city, this.address, this.password);

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    contact = map['contact'];
    city = map['city'];
    address = map['address'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnEmail : email,
      DatabaseHelper.columnContact : contact,
      DatabaseHelper.columnCity : city,
      DatabaseHelper.columnAddress : address,
      DatabaseHelper.columnPassword: password,
    };
  }
}