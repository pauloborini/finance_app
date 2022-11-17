import 'dart:math';
import 'package:despesasplus/models/income.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/colors_and_vars.dart';
import '../database/income_dao.dart';

class IncomeForm extends StatefulWidget {
  const IncomeForm({Key? key}) : super(key: key);

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
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
      child: Stack(
        children: [
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
                            color: Colors.green.shade800,
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
                        if (titleController.text.isEmpty ||
                            double.parse(valueController.text) <= 0) {
                          return;
                        }
                        final income = Income(
                            id: Random().nextDouble().toString(),
                            title: titleController.text,
                            value: double.parse(valueController.text),
                            date: _dateController.toIso8601String());
                        await IncomeDao().save(income);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tabColorGreen, elevation: 0),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Nova Entrada',
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
        ],
      ),
    );
  }
}
