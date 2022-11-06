import 'package:flutter/material.dart';
import '../components/expense_form.dart';
import '../components/expense_list.dart';
import '../components/floating_button.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;
  final Color tabColorRed = const Color.fromARGB(255, 250, 195, 195);

  _openExpenseModal1(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const ExpenseForm();
        }).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            ExpenseList(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: FloatingButton(
                  tabColor: tabColorRed,
                  onPressed: () => _openExpenseModal1(context)),
            ),
          ])
        ],
      ),
    );
  }
}
