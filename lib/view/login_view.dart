import 'package:flutter/material.dart';
import 'sigin_view.dart';

var mainPrimaryColor = Colors.black;
var mainApName = 'RN';
double? mainFontSize = 14;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController ctrl_email = TextEditingController();
  TextEditingController ctrl_senha = TextEditingController();

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
              customTextFormField('E-mail', ctrl_email),
              customTextFormField('Senha', ctrl_senha),
              ElevatedButton(
                onPressed: () {

                  bool resultado = validateEmail(ctrl_email.text);

                  if ( resultado ){
                      
                  }else{

                  }

                },
                child: Text('Login'),
              ),
              SizedBox(),
              Row(
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

customTextFormField(text, ctrl) {
  return TextFormField(
    controller: ctrl,
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      labelStyle: TextStyle(color: mainPrimaryColor),
      labelText: text,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: mainPrimaryColor),
      ),
    ),
  );
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

bool validateEmail(String email) {
  String padraoEmail = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regExp = RegExp(padraoEmail);

  return regExp.hasMatch(email);
}
