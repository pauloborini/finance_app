import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/colors_and_vars.dart';

class Income extends StatelessWidget {
  final String id;
  final String title;
  final double value;
  final String date;

  const Income({
    Key? key,
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: stanColor,
      color: stanColor,
      shadowColor: tabColorGreen,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(colors: [
              tabColorGreen,
              Colors.greenAccent,
              Colors.green,
            ])),
        width: double.infinity,
        height: 70,
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
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: fontColor)),
                  Text(DateFormat('d MMM y').format(DateTime.parse(date)),
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade800)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black12),
                    // color: tabColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: FittedBox(
                  child: Text(
                    'R\$ ${value.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
