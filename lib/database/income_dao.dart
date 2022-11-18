import 'package:sqflite/sqflite.dart';
import '../models/income.dart';
import 'database.dart';

class IncomeDao {
  static const String tableSql2 = 'CREATE TABLE $_incomeTable('
      '$_id TEXT, '
      '$_title TEXT, '
      '$_value REAL, '
      '$_datetime TEXT)';

  static const String _incomeTable = 'incomeTable';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _value = 'value';
  static const String _datetime = 'datetime';

  save(Income income) async {
    final Database dataBaseIncome = await getDatabase2();
    var itemExists = await find(income.title);
    if (itemExists.isEmpty) {
      return await dataBaseIncome.insert(_incomeTable, _toMap(income));
    } else {
      return await dataBaseIncome.update(_incomeTable, _toMap(income),
          where: '$_title = ?', whereArgs: [income.title]);
    }
  }

  Future<List<Income>> findSeven() async {
    final Database dataBaselocal = await getDatabase2();
    final dateFinal = DateTime.now().toIso8601String();
    final dateInitial =
    DateTime.now().subtract(const Duration(days: 7)).toIso8601String();
    final List<Map<String, dynamic>> result = await dataBaselocal.rawQuery(
        ''' SELECT * FROM $_incomeTable WHERE $_datetime BETWEEN '$dateInitial' AND '$dateFinal' ''');
    return toList(result);
  }

  Future<List<Income>> findAll() async {
    final Database dataBaseIncome = await getDatabase2();
    final List<Map<String, dynamic>> result =
    await dataBaseIncome.query(_incomeTable);
    return toList(result);
  }

  Future<List<Income>> find(String selectedTitle) async {
    final Database dataBaseIncome = await getDatabase2();
    final List<Map<String, dynamic>> result = await dataBaseIncome.query(
        _incomeTable,
        where: '$_title = ?',
        whereArgs: [selectedTitle]);
    return toList(result);
  }

  delete(String title) async {
    final Database dataBaseIncome = await getDatabase2();
    return dataBaseIncome.delete(_incomeTable,
        where: '$_title = ?', whereArgs: [title]);
  }

  List<Income> toList(List<Map<String, dynamic>> incomesList) {
    final List<Income> incomes = [];
    for (Map<String, dynamic> row in incomesList) {
      final Income income = Income(
        id: row[_id],
        title: row[_title],
        value: row[_value],
        date: row[_datetime],
      );
      incomes.add(income);
    }
    return incomes;
  }

  Map<String, dynamic> _toMap(Income income) {
    final Map<String, dynamic> incomeMap = {};
    incomeMap[_id] = income.id;
    incomeMap[_title] = income.title;
    incomeMap[_value] = income.value;
    incomeMap[_datetime] = income.date;
    return incomeMap;
  }
}
