import 'package:despesasplus/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class ExpenseDao {
  static const String tableSql1 = 'CREATE TABLE $_expenseTable('
      '$_id TEXT, '
      '$_title TEXT, '
      '$_value REAL, '
      '$_datetime TEXT)';

  static const String _expenseTable = 'expenseTable';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _value = 'value';
  static const String _datetime = 'datetime';

  save(Expense expense) async {
    final Database dataBaselocal = await getDatabase1();
    var itemExists = await find(expense.title);
    if (itemExists.isEmpty) {
      return await dataBaselocal.insert(_expenseTable, _toMap(expense));
    } else {
      return await dataBaselocal.update(_expenseTable, _toMap(expense),
          where: '$_title = ?', whereArgs: [expense.title]);
    }
  }

  Future<List<Expense>> findSeven() async {
    final Database dataBaselocal = await getDatabase1();
    final dateFinal = DateTime.now().toIso8601String();
    final dateInitial =
    DateTime.now().subtract(const Duration(days: 7)).toIso8601String();
    final List<Map<String, dynamic>> result = await dataBaselocal.rawQuery(
        ''' SELECT * FROM $_expenseTable WHERE $_datetime BETWEEN '$dateInitial' AND '$dateFinal' ''');
    return toList(result);
  }


  Future<List<Expense>> findAll() async {
    final Database dataBaselocal = await getDatabase1();
    final List<Map<String, dynamic>> result =
    await dataBaselocal.query(_expenseTable);
    return toList(result);
  }

  Future<List<Expense>> find(String selectedTitle) async {
    final Database dataBaselocal = await getDatabase1();
    final List<Map<String, dynamic>> result = await dataBaselocal
        .query(_expenseTable, where: '$_title = ?', whereArgs: [selectedTitle]);
    return toList(result);
  }

  delete(String title) async {
    final Database dataBaselocal = await getDatabase1();
    return dataBaselocal
        .delete(_expenseTable, where: '$_title = ?', whereArgs: [title]);
  }

  List<Expense> toList(List<Map<String, dynamic>> expensesList) {
    final List<Expense> expenses = [];
    for (Map<String, dynamic> row in expensesList) {
      final Expense expense = Expense(
        id: row[_id],
        title: row[_title],
        value: row[_value],
        date: row[_datetime],
      );
      expenses.add(expense);
    }
    return expenses;
  }

  Map<String, dynamic> _toMap(Expense expense) {
    final Map<String, dynamic> expenseMap = {};
    expenseMap[_id] = expense.id;
    expenseMap[_title] = expense.title;
    expenseMap[_value] = expense.value;
    expenseMap[_datetime] = expense.date;
    return expenseMap;
  }
}
