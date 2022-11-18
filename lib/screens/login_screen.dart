import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:validatorless/validatorless.dart';
import '../components/colors_and_vars.dart';
import '../services/auth/signing_service.dart';
import 'forgot_password_screen.dart';
import 'initial_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset('assets/images/bloom_logo.png',
                        fit: BoxFit.cover),
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
                      validator: Validatorless.multiple([
                        Validatorless.required('Email Obrigatório'),
                        Validatorless.email('Email Inválido')
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.alternate_email),
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(fontSize: 20, fontFamily: 'Login'),
                        contentPadding: EdgeInsets.zero,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.number('Apenas números'),
                          Validatorless.required('Senha Obrigatória'),
                          Validatorless.min(
                              8, 'Senha deve ter no mínimo 8 números'),
                          Validatorless.max(
                              16, 'Senha pode ter no máximo 16 números')
                        ]),
                        obscureText: _hidePassword,
                        keyboardType: TextInputType.number,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock_outline),
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                              fontSize: 20, fontFamily: 'Login'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () {
                            showBarModalBottomSheet(
                                context: context,
                                builder: (context) => ForgotPasswordScreen());
                          },
                          child: const Text(
                            'Esqueceu a senha?',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: standardBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Login'),
                          )),
                    ],
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
                            var formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              SigningService().signing(_emailController.text,
                                  int.parse(_passwordController.text));
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InitialScreen()),
                                  (route) => false);
                            }
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                                fontFamily: 'Login',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Center(child: Text('OU')),
                  ),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black12),
                          elevation: MaterialStateProperty.all(0),
                          overlayColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'assets/images/google.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Text(
                              '       Entrar com Google',
                              style: TextStyle(
                                  fontFamily: 'Login',
                                  fontSize: 20,
                                  color: Colors.black54),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Novo por aqui?',
                          style: TextStyle(fontSize: 17, fontFamily: 'Login'),
                        ),
                        TextButton(
                            onPressed: () {
                              showBarModalBottomSheet(
                                  context: context,
                                  builder: (context) => RegisterScreen());
                            },
                            child: const Text(
                              'Registre-se',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Login',
                                  fontWeight: FontWeight.bold,
                                  color: standardBlue),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
