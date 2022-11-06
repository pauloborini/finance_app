import 'dart:math';
import 'package:despesasplus/database/expense_dao.dart';
import 'package:despesasplus/models/expense.dart';
import 'package:flutter/material.dart';
import 'standard_button.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({Key? key}) : super(key: key);

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
          child: Column(
            children: [
              TextField(
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(labelText: 'Título'),
                  controller: titleController),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: 'Valor R\$ (Ex: 100.00) ',
                ),
                controller: valueController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StandardButton(
                    text: 'Nova Despesa',
                    height: 15,
                    width: 150,
                    onSubmit: () async {
                      if (titleController.text.isEmpty ||
                          double.parse(valueController.text) <= 0) {
                        return;
                      }
                      final expense = Expense(
                          id: Random().nextDouble().toString(),
                          title: titleController.text,
                          value: double.parse(valueController.text),
                          date: DateTime.now().toIso8601String());
                      await ExpenseDao().save(expense);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
