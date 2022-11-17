import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/colors_and_vars.dart';

class Dream extends StatelessWidget {
  final String id;
  final String title;
  final double value;

  const Dream(
      {super.key, required this.title, required this.value, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      child: Card(
        shadowColor: tabColorAmber,
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: [
                Colors.orangeAccent,
                Colors.orangeAccent,
                Colors.yellow.shade100,
              ])),
          width: double.infinity,
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 4, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                      child: Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: fontColor)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Text(DateFormat('d MMM y').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Center(
                          child: Text(
                        'R\$ ${value.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
