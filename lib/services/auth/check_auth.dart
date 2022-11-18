import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../screens/initial_screen.dart';
import '../../screens/login_screen.dart';

class CheckAuth extends StatefulWidget {
  CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {

  final bool userIsAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return userIsAuthenticated ? InitialScreen() : LoginScreen();
  }
}
