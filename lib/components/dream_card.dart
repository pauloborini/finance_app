import 'package:despesasplus/components/sticky_note.dart';
import 'package:flutter/material.dart';

class PostIT extends StatelessWidget {
  PostIT({Key? key}) : super(key: key);
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 340,
        height: 250,
        color: stanColor,
        child: StickyNote(),
      ),
    );
  }
}