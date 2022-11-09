import 'package:flutter/material.dart';
import '../../database/income_dao.dart';
import '../../models/income.dart';
import '../circular_progress.dart';

class IncomeList extends StatefulWidget {
  final double height;
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;

  IncomeList({Key? key, required this.height}) : super(key: key);

  @override
  State<IncomeList> createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height * 0.99,
      child: FutureBuilder<List<Income>>(
        future: IncomeDao().findAll(),
        builder: (context, snapshot) {
          List<Income>? items = snapshot.data?.reversed.toList();
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
                      final Income incomes = items[index];
                      return Dismissible(
                        key: ValueKey<Income>(incomes),
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
                                const Text("Você quer deletar a entrada?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: widget.stanColor,
                                          elevation: 0,
                                          foregroundColor: widget.fontColor,
                                          surfaceTintColor: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        IncomeDao().delete(incomes.title);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                                '${incomes.title} apagada')));
                                      },
                                      child: const Text("Deletar")),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: widget.stanColor,
                                        elevation: 0,
                                        foregroundColor: widget.fontColor,
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
                        child: Container(child: incomes),
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
                        Text('Sem entradas registradas',
                            style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ));
          }
          return const Text('Aguarde...');
        },
      ),
    );
  }
}
