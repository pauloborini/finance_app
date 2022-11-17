import 'package:flutter/material.dart';
import '../components/colors_and_vars.dart';
import '../components/floating_button.dart';
import '../forms/income_form.dart';
import '../components/incomes/income_list.dart';

class IncomeScreen extends StatefulWidget {
  final double height;

  const IncomeScreen({Key? key, required this.height}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {

  _openExpenseModal2(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const IncomeForm();
        }).then((value) => setState(() {
    }));
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            IncomeList(height: widget.height,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: FloatingButton(
                  tabColor: tabColorGreen,
                  onPressed: () => _openExpenseModal2(context)),
            ),
          ])
        ],
      ),
    );
  }
}
