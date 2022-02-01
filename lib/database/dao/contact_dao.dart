import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ContactDao {

  static const _tableName= 'contacts';
  static const _id = 'id';
  static const _name = 'name';
  static const _accountNumber = 'account_number';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> save(Contact contact) {
    return createDatabase().then((db) {
      return _toMap(contact, db);
    });
  }

  Future<int> _toMap(Contact contact, Database db) {
       final Map<String, dynamic> contactMap = {};
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return db.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() {
    return createDatabase().then((db) {
      return db.query(_tableName).then((maps) {
        return _toList(maps);
      });
    });
  }

  List<Contact> _toList(List<Map<String, Object?>> maps) {
        final List<Contact> contacts = [];
    for (Map<String, dynamic> map in maps) {
      final Contact contact = Contact(
        map[_id],
        map[_name],
        map[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
