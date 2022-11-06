import 'package:despesasplus/components/dream_list.dart';
import 'package:flutter/material.dart';
import '../components/dream_card.dart';
import '../components/dream_form.dart';
import '../components/floating_button.dart';

class DreamScreen extends StatefulWidget {
  const DreamScreen({Key? key}) : super(key: key);

  @override
  State<DreamScreen> createState() => _DreamScreenState();
}

class _DreamScreenState extends State<DreamScreen> {
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;
  final Color tabColorAmber = const Color.fromARGB(255, 251, 255, 174);

  _openExpenseModal3(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const DreamForm();
        }).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DreamList(),
          Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            PostIT(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
              child: FloatingButton(
                  tabColor: tabColorAmber,
                  onPressed: () => _openExpenseModal3(context)),
            )
          ]),
        ],
      ),
    );
  }
}
