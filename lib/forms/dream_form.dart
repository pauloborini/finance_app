import 'dart:math';

import 'package:despesasplus/database/dream_dao.dart';
import 'package:flutter/material.dart';
import '../models/dream.dart';
import '../components/standard_button.dart';

class DreamForm extends StatefulWidget {
  const DreamForm({Key? key}) : super(key: key);

  @override
  State<DreamForm> createState() => _DreamFormState();
}

class _DreamFormState extends State<DreamForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;
  final Color tabColorAmber = const Color.fromARGB(255, 251, 255, 174);

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
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.isEmpty ||
                            double.parse(valueController.text) <= 0) {
                          return;
                        }
                        final dream = Dream(
                          id: Random().nextDouble().toString(),
                          title: titleController.text,
                          value: double.parse(valueController.text),
                        );
                        await DreamDao().save(dream);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: tabColorAmber, elevation: 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Nova Meta', style: TextStyle(color: fontColor, fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}