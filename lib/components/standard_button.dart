import 'package:flutter/material.dart';

import 'colors_and_vars.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Function onSubmit;

  const StandardButton(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      highlightColor: const Color.fromARGB(255, 218, 224, 243),
      highlightElevation: 0,
      elevation: 0,
      color: Colors.transparent,
      height: height,
      minWidth: width,
      onPressed: () {
        onSubmit();
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: fontColor),
      ),
    );
  }
}
