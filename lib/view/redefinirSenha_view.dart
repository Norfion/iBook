// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';

class RedefinirsenhaView extends StatefulWidget {
  const RedefinirsenhaView({super.key});

  @override
  State<RedefinirsenhaView> createState() => _RedefinirsenhaViewState();
}

class _RedefinirsenhaViewState extends State<RedefinirsenhaView> {
  // Controladores de TextFormField()
  TextEditingController _ctrlEmail = TextEditingController();

  // Validadores de Form()
  final _vlddEmail = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corTerciaria,
      body: Stack(
        children: [
          // Terço superior com fundo preto
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: corTerciaria,
          ),
          // Dois terços inferiores com fundo branco e bordas arredondadas
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: corSecundaria,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(90),
                ),
              ),
            ),
          ),
          // Elementos elevados sobre os fundos
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: corSecundaria,
                        iconSize: 40, // Seta de voltar
                        onPressed: () {
                          Navigator.pop(context); // Retorna à tela anterior
                        },
                      ),
                    ],
                  )),
                  SizedBox(height: 150),
                  Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: corSecundaria,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 50), // Espaçamento entre textos
                  Text(
                    'Sem problemas! Informe seu e-mail que iremos te enviar uma mensagem de recuperação de senha',
                    style: TextStyle(
                      fontSize: 18,
                      color: corPrimaria,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 50), // Espaçamento entre o texto e o campo
                  Form(
                      key: _vlddEmail,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('E-mail', style: TextStyle(fontFamily: fonte)),
                          ],
                        ),
                        TextFormField(
                          controller: _ctrlEmail,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: corPrimaria),
                            labelText: 'Insira um e-mail de recuperação',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: corPrimaria),
                            ),
                          ),
                          validator: (email) {
                            // Procedimento para verificar se o e-mail é válido avaliando
                            // a composição de caracteres
                            String padraoEmail =
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            RegExp regExp = RegExp(padraoEmail);

                            if (email == null || email.isEmpty) {
                              return 'Informe um e-mail';
                            } else if (!regExp.hasMatch(email)) {
                              return 'Informe um e-mail VÁLIDO';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40), // Espaçamento entre os campo
                        ElevatedButton(
                          onPressed: () {
                            bool existeEmail = false;
                            String email = _ctrlEmail.text;

                            for (int i = 0; i < usuarios.length; i++) {
                              if (usuarios[i].email == email) {
                                existeEmail = true;
                              }
                            }

                            // Verifica se o formato do email é válidp
                            if (_vlddEmail.currentState!.validate()) {
                              // Verifica se o email está cadastrado
                              if (existeEmail) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Um e-mail de recuperação de senha foi enviado para "${email}". Verifique sua caixa de entrada'),
                                  duration: Duration(seconds: 15),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'O e-mail inserido não foi encontrado. Tente outro e-mail.'),
                                  duration: Duration(seconds: 5),
                                ));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  corTerciaria, // Cor de fundo preta corSecundaria,
                              foregroundColor:
                                  corSecundaria, // Cor do texto branco
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Cantos levemente arredondados
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 32.0)),
                          child: Text('Redefinir senha',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                      ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
