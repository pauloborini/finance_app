import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final String message;

  const CircularProgress(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator.adaptive(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message, style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
