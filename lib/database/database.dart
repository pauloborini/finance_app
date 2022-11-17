import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dream_dao.dart';
import 'expense_dao.dart';
import 'income_dao.dart';


Future<Database> getDatabase1() async {
  final String path = join(await getDatabasesPath(), 'expense.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ExpenseDao.tableSql1);
    },
    version: 1,
  );
}

Future<Database> getDatabase2() async {
  final String path = join(await getDatabasesPath(), 'income.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(IncomeDao.tableSql2);
    },
    version: 1,
  );
}

Future<Database> getDatabase3() async {
  final String path = join(await getDatabasesPath(), 'dream1.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(DreamDao.tableSql3);
    },
    version: 1,
  );
}

Future<Database> getDatabase4() async {
  final String path = join(await getDatabasesPath(), 'dream1.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(DreamDao.tableSql3);
    },
    version: 1,
  );
}

