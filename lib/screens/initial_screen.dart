import 'package:despesasplus/database/expense_dao.dart';
import 'package:despesasplus/database/income_dao.dart';
import 'package:despesasplus/models/expense.dart';
import 'package:despesasplus/models/income.dart';
import 'package:despesasplus/models/user.dart';
import 'package:despesasplus/screens/expense_screen.dart';
import 'package:despesasplus/screens/income_screen.dart';
import 'package:despesasplus/screens/info_screen.dart';
import 'package:despesasplus/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:despesasplus/screens/dream_screen.dart';
import 'package:flutter/services.dart';
import '../components/colors_and_vars.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({super.key});

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
    final appBar = AppBar(
      backgroundColor: stanColor,
      elevation: 0,
      centerTitle: true,
      title: AnimatedDefaultTextStyle(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Login',
          color: color,
        ),
        duration: const Duration(milliseconds: 1000),
        child: Text(
          title,
          style:
              TextStyle(fontSize: 30 * MediaQuery.of(context).textScaleFactor),
        ),
      ),
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        kBottomNavigationBarHeight;

    List body = [
      DreamScreen(height: availableHeight),
      IncomeScreen(height: availableHeight),
      ExpenseScreen(height: availableHeight),
      InfoScreen(
          listToChartExpenses: widget.listToChartExpenses,
          listToChartIncomes: widget.listToChartIncomes,
          height: availableHeight),
      ProfileScreen(),
    ];
    return Scaffold(
      backgroundColor: stanColor,
      appBar: appBar,
      body: SizedBox(child: body.elementAt(currentIndex)),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: BottomNavigationBar(
          backgroundColor: stanColor,
          currentIndex: currentIndex,
          onTap: (index) {
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
              } else if (currentIndex == 3) {
                color = Colors.black87;
                title = 'Informações';
              } else if (currentIndex == 4) {
                color = Colors.black87;
                title = 'Perfil';
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.star, color: Color(-1139968)),
                label: 'Metas',
                backgroundColor: tabColorAmber),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money, color: iconColor),
              label: 'Entradas',
              backgroundColor: tabColorGreen,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.money_off, color: iconColor),
                label: 'Saídas',
                backgroundColor: tabColorRed),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline, color: iconColor),
                label: 'Info',
                backgroundColor: tabColorPurple),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: iconColor),
                label: 'Perfil',
                backgroundColor: tabColorBlue),
          ],
        ),
      ),
    );
  }
}
