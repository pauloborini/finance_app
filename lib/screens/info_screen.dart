import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/colors_and_vars.dart';
import '../components/info/chart_bar.dart';
import '../models/expense.dart';
import '../models/income.dart';

class InfoScreen extends StatefulWidget {
  final double height;
  final List<Expense> listToChartExpenses;
  final List<Income> listToChartIncomes;

  InfoScreen(
      {super.key,
      required this.listToChartExpenses,
      required this.listToChartIncomes,
      required this.height});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<Map<String, Object>> get groupedExpenses {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.00;
      for (var i = 0; i < widget.listToChartExpenses.length; i++) {
        DateTime datechart = DateTime.parse(widget.listToChartExpenses[i].date);
        bool sameDay = datechart.day == weekDay.day;
        bool sameMonth = datechart.month == weekDay.month;
        bool sameYear = datechart.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalSum += widget.listToChartExpenses[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  List<Map<String, Object>> get groupedIncomes {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.00;
      for (var i = 0; i < widget.listToChartIncomes.length; i++) {
        DateTime datechart = DateTime.parse(widget.listToChartIncomes[i].date);
        bool sameDay = datechart.day == weekDay.day;
        bool sameMonth = datechart.month == weekDay.month;
        bool sameYear = datechart.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalSum += widget.listToChartIncomes[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedExpenses.fold(0.0, (sum, ex) {
      return sum += (ex['value'] as double);
    });
  }

  double get _weekTotalValueIncomes {
    return groupedIncomes.fold(0.0, (sum, ex) {
      return sum += (ex['value'] as double);
    });
  }

  bool visibilityIncomes = false;
  bool visibilityExpenses = false;

  bool visibilityIn() {
    if (widget.listToChartIncomes.isNotEmpty) {
      return visibilityIncomes = true;
    }
    return visibilityIncomes = false;
  }

  bool visibilityEx() {
    if (widget.listToChartExpenses.isNotEmpty) {
      return visibilityExpenses = true;
    }
    return visibilityExpenses = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stanColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: visibilityExpenses,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 2),
                child: Center(
                  child: Text(
                    'Gráfico: Saída de Capital (Semanal)',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: visibilityExpenses,
              child: SizedBox(
                width: double.infinity,
                height: 164,
                child: Card(
                  surfaceTintColor: tabColorRed,
                  shadowColor: tabColorRed,
                  elevation: 6,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: groupedExpenses.map((ex) {
                        return Flexible(
                          fit: FlexFit.tight,
                          child: ChartBar(
                            label: ex['day'].toString(),
                            value: (ex['value'] as double),
                            percentage: _weekTotalValue == 0
                                ? 0
                                : (ex['value'] as double) / _weekTotalValue,
                            colorBar: tabColorRed,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: visibilityIncomes,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 2),
                child: Center(
                  child: Text(
                    'Gráfico: Entrada de Capital (Semanal)',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: visibilityIncomes,
              child: SizedBox(
                width: double.infinity,
                height: 164,
                child: Card(
                  surfaceTintColor: tabColorGreen,
                  shadowColor: tabColorGreen,
                  elevation: 6,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: groupedIncomes.map((ex) {
                        return Flexible(
                          fit: FlexFit.tight,
                          child: ChartBar(
                            label: ex['day'].toString(),
                            value: (ex['value'] as double),
                            percentage: _weekTotalValueIncomes == 0
                                ? 0
                                : (ex['value'] as double) /
                                    _weekTotalValueIncomes,
                            colorBar: tabColorGreen,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: SizedBox(
          width: 135,
          child: FittedBox(
            child: FloatingActionButton.extended(
              backgroundColor: stanColor,
              foregroundColor: fontColor,
              label: const Text(
                'Integrar Dados',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  visibilityIn();
                  visibilityEx();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
