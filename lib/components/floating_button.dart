import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;
  final Color tabColor;
  final Function onPressed;

  const FloatingButton(
      {Key? key, required this.tabColor, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      highlightColor: stanColor,
      highlightElevation: 6,
      elevation: 2,
      color: tabColor,
      height: 60,
      minWidth: 60,
      onPressed: () {
        onPressed();
      },
      child: const Icon(Icons.add, size: 32),
    );
  }
}
