import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'dados.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(ContactDao.tableSql);
      },
      version: 1,
    );
  });
}
