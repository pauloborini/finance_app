import 'package:despesasplus/database/expense_dao.dart';
import 'package:despesasplus/database/income_dao.dart';
import 'package:despesasplus/models/expense.dart';
import 'package:despesasplus/models/income.dart';
import 'package:despesasplus/screens/expense_screen.dart';
import 'package:despesasplus/screens/income_screen.dart';
import 'package:despesasplus/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:despesasplus/screens/dream_screen.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({Key? key}) : super(key: key);
  List<Expense> listToChartExpenses = [];
  List<Income> listToChartIncomes = [];

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getList();
    getListIncomes();
  }

  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;
  final Color tabColorRed = const Color.fromARGB(255, 250, 195, 195);
  final Color tabColorGreen = const Color.fromARGB(255, 219, 241, 193);

  String title = 'Metas';
  Color color = Colors.orange;
  int currentIndex = 0;


  getList() async {
    Future<List<Expense>> listSeven = ExpenseDao().findSeven();
    widget.listToChartExpenses = await listSeven;
    return widget.listToChartExpenses;
  }
  getListIncomes() async {
    Future<List<Income>> listSeven = IncomeDao().findSeven();
    widget.listToChartIncomes = await listSeven;
    return widget.listToChartIncomes;
  }

  @override
  Widget build(BuildContext context) {
    List body = [
      const DreamScreen(),
      const IncomeScreen(),
      const ExpenseScreen(),
      InfoScreen(listToChartExpenses: widget.listToChartExpenses, listToChartIncomes: widget.listToChartIncomes,),
    ];
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: stanColor,
        appBar: AppBar(
          backgroundColor: stanColor,
          elevation: 0,
          centerTitle: true,
          title: AnimatedDefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              fontFamily: 'Roboto',
              color: color,
            ),
            duration: const Duration(milliseconds: 1000),
            child: Text(title),
          ),
        ),
        body: Center(
          child: body.elementAt(currentIndex),
        ),
        bottomNavigationBar: NavigationBar(
            height: 60,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: currentIndex,
            elevation: 0,
            backgroundColor: stanColor,
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.star, color: Colors.amber), label: 'Metas'),
              NavigationDestination(
                  icon: Icon(Icons.attach_money), label: 'Entradas'),
              NavigationDestination(
                  icon: Icon(Icons.money_off), label: 'Saídas'),
              NavigationDestination(
                  icon: Icon(Icons.info_outline), label: 'Info'),
            ],
            onDestinationSelected: (int index) {
              setState(() {
                getListIncomes();
                getList();
                currentIndex = index;
                if (currentIndex == 0) {
                  color = Colors.orange;
                  title = 'Metas';
                } else if (currentIndex == 1) {
                  color = Colors.green;
                  title = 'Entradas';
                } else if (currentIndex == 2) {
                  color = Colors.red;
                  title = 'Saídas';
                  } else if (currentIndex == 3){
                    color = Colors.black87;
                    title = 'Informações';
                }
              });
            }),
      ),
    );
  }
}
