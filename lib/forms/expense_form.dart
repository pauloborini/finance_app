import 'dart:math';
import 'package:despesasplus/database/expense_dao.dart';
import 'package:despesasplus/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/colors_and_vars.dart';

class ExpenseForm extends StatefulWidget {
  ExpenseForm({Key? key}) : super(key: key);

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  DateTime _dateController = DateTime.now();

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateController = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          color: stanColor,
        ),
        Container(
          color: stanColor,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              TextField(
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(labelText: 'Título'),
                  controller: _titleController),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: 'Valor R\$ (Ex: 100.00) ',
                ),
                controller: _valueController,
              ),
              Row(
                children: [
                  Text(DateFormat('dd/MM/y').format(_dateController)),
                  MaterialButton(
                    onPressed: () {
                      _showDatePicker();
                    },
                    elevation: 0,
                    color: stanColor,
                    splashColor: stanColor,
                    highlightColor: stanColor,
                    highlightElevation: 0,
                    enableFeedback: false,
                    child: Text(
                      'Selecione a data',
                      style: TextStyle(
                          color: Colors.red.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_titleController.text.isEmpty ||
                          double.parse(_valueController.text) <= 0) {
                        return;
                      }
                      final expense = Expense(
                          id: Random().nextDouble().toString(),
                          title: _titleController.text,
                          value: double.parse(_valueController.text),
                          date: _dateController.toIso8601String());
                      await ExpenseDao().save(expense);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tabColorRed, elevation: 0),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Nova Saída',
                        style: TextStyle(
                            color: fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
