import 'package:despesasplus/components/dreams/dream_list.dart';
import 'package:despesasplus/components/dreams/sticky_note.dart';
import 'package:flutter/material.dart';
import '../components/colors_and_vars.dart';
import '../forms/dream_form.dart';
import '../components/floating_button.dart';

class DreamScreen extends StatefulWidget {
  final double height;

  const DreamScreen({Key? key, required this.height}) : super(key: key);

  @override
  State<DreamScreen> createState() => _DreamScreenState();
}

class _DreamScreenState extends State<DreamScreen> {
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
          SizedBox(
              width: double.infinity,
              height: widget.height * 0.6,
              child: DreamList()),
          Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            SizedBox(
                width: double.infinity,
                height: widget.height * 0.39,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                  child: StickyNote(
                    height: widget.height,
                  ),
                )),
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
