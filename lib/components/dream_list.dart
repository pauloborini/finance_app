import 'package:flutter/material.dart';
import '../database/dream_dao.dart';
import '../database/income_dao.dart';
import '../models/dream.dart';
import 'circular_progress.dart';

class DreamList extends StatefulWidget {
  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);
  final Color fontColor = Colors.black87;

  DreamList({Key? key}) : super(key: key);

  @override
  State<DreamList> createState() => _DreamListState();
}

class _DreamListState extends State<DreamList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 320,
      child: FutureBuilder<List<Dream>>(
        future: DreamDao().findAll(),
        builder: (context, snapshot) {
          List<Dream>? items = snapshot.data?.reversed.toList();
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
                      final Dream dreams = items[index];
                      return Dismissible(
                        key: ValueKey<Dream>(dreams),
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
                                const Text("Você quer deletar a meta?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: widget.stanColor,
                                          elevation: 0,
                                          foregroundColor: widget.fontColor,
                                          surfaceTintColor: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        DreamDao().delete(dreams.title);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                                '${dreams.title} apagada')));
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
                          color: widget.stanColor,
                          child: const Align(
                            alignment: Alignment(-0.9, 0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.black87,
                              size: 32,
                            ),
                          ),
                        ),
                        child: Container(child: dreams),
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
                        Text('Sem metas registradas',
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
