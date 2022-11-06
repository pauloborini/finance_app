import 'package:flutter/material.dart';
import '../components/floating_button.dart';
import '../components/income_form.dart';
import '../components/income_list.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;
  final Color tabColorGreen = const Color.fromARGB(255, 219, 241, 193);

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
            IncomeList(),
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
