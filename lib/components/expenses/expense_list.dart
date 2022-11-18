import 'package:flutter/material.dart';
import '../../database/expense_dao.dart';
import '../../models/expense.dart';
import '../circular_progress.dart';
import '../colors_and_vars.dart';

class ExpenseList extends StatefulWidget {
  final double height;

  ExpenseList({Key? key, required this.height}) : super(key: key);

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height * 0.99,
      child: FutureBuilder<List<Expense>>(
        future: ExpenseDao().findAll() as Future<List<Expense>>,
        builder: (context, snapshot) {
          List<Expense>? items = snapshot.data?.reversed.toList();
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              const CircularProgress('Carregando');
              break;
            case ConnectionState.active:
              const CircularProgress('Carregando');
              break;
            case ConnectionState.done:
              if (snapshot.hasData && items != null) {
                if (items.isNotEmpty) {
                  return ListView.builder(
                    reverse: false,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Expense expenses = items[index];
                      return Dismissible(
                        key: ValueKey<Expense>(expenses),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          setState(() {});
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmação"),
                                content:
                                    const Text("Você quer deletar a despesa?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: stanColor,
                                          elevation: 0,
                                          foregroundColor: fontColor,
                                          surfaceTintColor: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        ExpenseDao().delete(expenses.title);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${expenses.title} apagada')));
                                      },
                                      child: const Text("Deletar")),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: stanColor,
                                        elevation: 0,
                                        foregroundColor: fontColor,
                                        surfaceTintColor: Colors.white),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text("Cancelar"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        background: Container(
                          color: const Color(0xFF222223),
                          child: const Align(
                            alignment: Alignment(-0.9, 0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        child: Container(child: expenses),
                      );
                    },
                  );
                }
              }
              return Center(
                  child: SizedBox(
                width: double.maxFinite,
                height: 380,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline,
                      size: 56,
                    ),
                    Text('Sem despesas registradas',
                        style: TextStyle(fontSize: 20))
                  ],
                ),
              ));
          }
          return const CircularProgress('Carregando');
        },
      ),
    );
  }
}
