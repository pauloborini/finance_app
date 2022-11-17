import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/functions.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Despesas+',
      theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              showUnselectedLabels: false,
              elevation: 0,
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Colors.black87),
          useMaterial3: true,
          focusColor: stanColor,
          fontFamily: 'Login',
          primaryColor: stanColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: stanColor,
                  foregroundColor: Colors.black87,
                  elevation: 4)),
          appBarTheme: const AppBarTheme(
              scrolledUnderElevation: 0,
              elevation: 0,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'Login'))),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
