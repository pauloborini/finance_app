import 'package:flutter/material.dart';
import '../components/colors_and_vars.dart';
import '../forms/expense_form.dart';
import '../components/expenses/expense_list.dart';
import '../components/floating_button.dart';

class ExpenseScreen extends StatefulWidget {
  final double height;

  const ExpenseScreen({Key? key, required this.height}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  _openExpenseModal1(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return ExpenseForm();
        }).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            ExpenseList(height: widget.height),
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
