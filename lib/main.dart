import 'package:despesasplus/screens/initial_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despesas+',
      theme: ThemeData(
          useMaterial3: true,
          focusColor: stanColor,
          fontFamily: 'PTSans',
          primaryColor: stanColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: stanColor,
                  foregroundColor: Colors.black87,
                  elevation: 4)),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'Roboto'))),
      home: InitialScreen(),
    );
  }
}
