import 'package:despesasplus/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/colors_and_vars.dart';
import 'initial_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  bool _hidePassword = true;
  Icon visibleOrNot = const Icon(Icons.visibility);

  getIcon() {
    if (_hidePassword == true) {
      visibleOrNot = const Icon(Icons.visibility);
    } else {
      visibleOrNot = const Icon(Icons.visibility_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: stanColor,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      backgroundColor: stanColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          color: stanColor,
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text('Login',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Login')),
                ),
                TextFormField(
                    obscureText: _hidePassword,
                    keyboardType: TextInputType.number,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock_outline),
                      labelText: 'Senha',
                      labelStyle:
                          const TextStyle(fontSize: 20, fontFamily: 'Login'),
                      contentPadding: EdgeInsets.zero,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                            getIcon();
                          });
                        },
                        icon: visibleOrNot,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: TextFormField(
                      obscureText: _hidePassword,
                      keyboardType: TextInputType.number,
                      controller: _password2Controller,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock_outline),
                        labelText: 'Senha',
                        labelStyle:
                            const TextStyle(fontSize: 20, fontFamily: 'Login'),
                        contentPadding: EdgeInsets.zero,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                              getIcon();
                            });
                          },
                          icon: visibleOrNot,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(standardBlue),
                          elevation: MaterialStateProperty.all(0),
                          overlayColor: MaterialStateProperty.all(standardBlue),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: const Text(
                          'Alterar',
                          style: TextStyle(
                              fontFamily: 'Login',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey),
                            elevation: MaterialStateProperty.all(0),
                            overlayColor:
                                MaterialStateProperty.all(Colors.black12),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InitialScreen()),
                                (route) => false);
                          },
                          child: const Text(
                            'Voltar',
                            style: TextStyle(
                                fontFamily: 'Login',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
