import 'package:flutter/material.dart';
import 'services/auth/check_auth.dart';
import 'components/functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(                                                   ///Firebase init
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final Color stanColor = const Color.fromARGB(255, 245, 245, 245);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Bloom Finance',
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
      home: CheckAuth(),
      debugShowCheckedModeBanner: false,
    );
  }
}
