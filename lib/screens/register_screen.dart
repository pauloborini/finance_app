import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:validatorless/validatorless.dart';
import '../components/colors_and_vars.dart';
import '../services/auth/signup_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  void sendData() {
    String id = const Uuid().v1();
    db.collection("user").doc(id).set({
      "name": _nameController.text,
      "email": _emailController.text,
      "pass": _passwordController.text
    });
  }

  void refresh() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stanColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.80,
          color: stanColor,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Registro',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Login')),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                    child: TextFormField(
                        validator: Validatorless.required('Nome Obrigatório'),
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Nome Completo',
                          labelStyle:
                              TextStyle(fontSize: 20, fontFamily: 'Login'),
                          contentPadding: EdgeInsets.zero,
                        )),
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha Obrigatória'),
                          Validatorless.min(
                              8, 'Senha deve ter no mínimo 8 caracteres'),
                          Validatorless.max(
                              20, 'Senha pode ter no máximo 20 caracteres')
                        ]),
                        obscureText: _hidePassword,
                        keyboardType: TextInputType.text,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha Obrigatória'),
                          Validatorless.compare(
                              _passwordController, 'Senhas devem ser idênticas')
                        ]),
                        obscureText: _hidePassword,
                        keyboardType: TextInputType.text,
                        controller: _password2Controller,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock_outline),
                          labelText: 'Confirme a Senha',
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
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: standardBlue),
                        onPressed: () {
                          var formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            SignUpService().signUp(_emailController.text,
                                _passwordController.text);
                            sendData();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Registro realizado com sucesso')));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                        },
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                              fontFamily: 'Login',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Já está cadastrado?',
                          style: TextStyle(fontSize: 17, fontFamily: 'Login'),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: const Text(
                              'Faça login aqui!',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Login',
                                  fontWeight: FontWeight.bold,
                                  color: standardBlue),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
