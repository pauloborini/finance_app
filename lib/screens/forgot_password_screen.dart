import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/colors_and_vars.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stanColor,
      appBar: AppBar(
        backgroundColor: stanColor,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: stanColor,
          child: Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.24,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Text('Esqueceu a Senha?',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Login')),
                  ),
                  Text(
                      'Não se preocupe, adicione abaixo seu Email para iniciarmos o processo de recuperação.'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.alternate_email),
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(fontSize: 20, fontFamily: 'Login'),
                          contentPadding: EdgeInsets.zero,
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
                            overlayColor:
                                MaterialStateProperty.all(standardBlue),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text(
                            'Enviar',
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
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
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
              )),
        ),
      ),
    );
  }
}
