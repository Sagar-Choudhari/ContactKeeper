import 'package:logreg/databasehelper/dbhelper.dart';

class Contact {
  int? id;
  String? user;
  String? name;
  String? contact;
  String? address;

  Contact(this.id, this.user, this.name, this.contact, this.address);

  Contact.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    user = map['user'];
    name = map['name'];
    contact = map['contact'];
    address = map['address'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.contactId: id,
      DatabaseHelper.contactUser: user,
      DatabaseHelper.contactName: name,
      DatabaseHelper.contactContact: contact,
      DatabaseHelper.contactAddress: address
    };
  }
}
