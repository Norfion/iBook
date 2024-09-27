import 'package:flutter/material.dart';
import 'home_view.dart';
import 'sigin_view.dart';

var mainPrimaryColor = Colors.black;
var secondColor = Colors.white;
var mainApName = 'RN';
double? mainFontSize = 14;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlSenha = TextEditingController();
  final _vldtLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Bem-vindo ao ${mainApName}'),
          ),
          body: Column(
            children: [
              Icon(Icons.monetization_on, size: 250),

              // Formulário de validar entrada
              Form(
                  key: _vldtLogin,
                  child: Column(children: [
                    TextFormField(
                      controller: _ctrlEmail,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: mainPrimaryColor),
                        labelText: 'Insira seu e-mail',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: mainPrimaryColor),
                        ),
                      ),
                      // validator => funcaovalida(),
                      validator: (email) {
                        // Procedimento para verificar se o e-mail é válido avaliando
                        // a composição de caracteres
                        String padraoEmail =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        RegExp regExp = RegExp(padraoEmail);

                        if (email == null || email.isEmpty) {
                          return 'Informe seu e-mail';
                        } else if (!regExp.hasMatch(email)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      controller: _ctrlSenha,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: mainPrimaryColor),
                        labelText: 'Insira sua senha',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: mainPrimaryColor),
                        ),
                      ),
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Informe sua senha';
                        } else if (password.length > 30) {
                          return 'Senha inválida';
                        } else {
                          return null;
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_vldtLogin.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        }
                      },
                      child: Text('Login'),
                    )
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Não tem conta? '),
                  customGestureDetector(context, 'Cadastre-se', SiginView()),
                ],
              )
            ],
          )),
    );
  }
}

customGestureDetector(context, text, view) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => view),
      );
    },
    child: Text(
      text,
      style: TextStyle(fontSize: mainFontSize, color: Colors.lightBlue),
    ),
  );
}

customTextFormField(text, controller, validator_function) {
  return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: mainPrimaryColor),
        labelText: 'Insira seu e-mail',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: mainPrimaryColor),
        ),
      ),
      // validator => funcaovalida(),
      validator: (value) => validator_function);
}
