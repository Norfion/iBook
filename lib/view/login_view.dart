// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controller/funcoes.dart';
import 'principal_view.dart';
import 'sigin_view.dart';
import 'redefinirSenha_view.dart';
import 'package:projeto_p1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Controladores de TextFormField()
  final TextEditingController _ctrlSenha = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();

  // Validadores de Form()
  final _vlddLogin = GlobalKey<FormState>();

  // Variaveis da tela
  double? tamIcone = 110.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corTerciaria,
      body: Stack(
        children: [
          // Terço superior com fundo preto
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            color: corTerciaria,
          ),
          // Dois terços inferiores com fundo branco e bordas arredondadas
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.67,
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
              top: MediaQuery.of(context).size.height * 0.20,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: (tamIcone! + 60),
                        height: (tamIcone! + 60),
                        decoration: BoxDecoration(
                          color: corTerciaria, // Cor de fundo da moldura
                          border: Border.all(
                            color: corSecundaria, // Cor da borda
                            width: 4, // Largura da borda
                          ),
                          borderRadius: BorderRadius.circular(
                              20), // Define o arredondamento das bordas
                        ),
                        child: Icon(Icons.auto_stories,
                            size: tamIcone, color: corSecundaria)),
                    SizedBox(height: 30),
                    Text(
                      'iBOOK',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: corPrimaria,
                        fontFamily: fonte,
                      ),
                    ),
                    Text(
                      'Leitura sem limites',
                      style: TextStyle(
                        fontSize: 24,
                        color: corPrimaria,
                        fontFamily: fonte,
                      ),
                    ),
                    SizedBox(height: 24), // Espaçamento entre o texto e o campo
                    Form(
                        key: _vlddLogin,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('E-mail',
                                  style: TextStyle(fontFamily: fonte)),
                            ],
                          ),
                          TextFormField(
                            controller: _ctrlEmail,
                            style: TextStyle(fontSize: 20, fontFamily: fonte),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: corPrimaria, fontFamily: fonte),
                              labelText: 'Insira seu e-mail',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                                return 'Informe seu e-mail';
                              } else if (!regExp.hasMatch(email)) {
                                return 'E-mail inválido';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Senha',
                                  style: TextStyle(fontFamily: fonte)),
                            ],
                          ), // Espaçamento entre os campos
                          TextFormField(
                            obscureText: true,
                            controller: _ctrlSenha,
                            style: TextStyle(fontSize: 20, fontFamily: fonte),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: corPrimaria, fontFamily: fonte),
                              labelText: 'Insira sua senha',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: corPrimaria),
                              ),
                            ),
                            validator: (senha) {
                              if (senha == null || senha.isEmpty) {
                                return 'Informe sua senha!';
                              } else if (senha.length > 30) {
                                return 'Senha inválida!';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Limpa as entradas de dados
                                  _ctrlEmail.clear();
                                  _ctrlSenha.clear();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RedefinirsenhaView()),
                                  );
                                },
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: corPrimaria,
                                      fontFamily: fonte,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              String email = _ctrlEmail.text.toString().trim();
                              String senha = _ctrlSenha.text.toString().trim();

                              // Autentica o usuário via Firebase Auth
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: senha)
                                  .then((res) {
                                // Caso esteja autenticado, redireciona para a tela Principal
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrincipalView()),
                                );

                                // Cria um documento do BD para gravar o nome do usuário
                                FirebaseFirestore.instance
                                    .collection('usuarios')
                                    .where('uid',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .get()
                                    .then((value) {
                                  usuarioLogado.nome =
                                      value.docs[0].data()['nome'] ?? '';
                                });
                              }).catchError((e)
                                      // Caso identifique erros, exibe uma mensagem de erro
                                      {
                                switch (e.code) {
                                  case 'invalid-email':
                                    String mensagem;
                                    (email.isEmpty || email == '')
                                        ? mensagem = 'Informe um e-mail!'
                                        : mensagem = 'E-mail inválido.';
                                    mostrarSnackBar(context, mensagem, 1);
                                    break;
                                  case 'user-not-found':
                                    mostrarSnackBar(
                                        context,
                                        'Não existe uma conta para o email $email. Clique em Registre-se para criar uma.',
                                        1);
                                    break;
                                  case 'wrong-password':
                                    mostrarSnackBar(context,
                                        'E-mail ou senha incorretos!', 1);
                                    break;
                                  case 'missing-password':
                                    mostrarSnackBar(
                                        context, 'Informe a senha!', 1);
                                    break;
                                  case 'invalid-credential':
                                    mostrarSnackBar(context,
                                        'E-mail ou senha incorretos!', 1);
                                    break;
                                  default:
                                    mostrarSnackBar(context,
                                        'Erro: ${e.code.toString()}', 1);
                                }
                              });
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
                            child: Text('Entrar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    fontFamily: fonte)),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Não tem conta? ',
                                  style: TextStyle(fontFamily: fonte)),
                              GestureDetector(
                                onTap: () {
                                  // Limpa as entradas de dados
                                  _ctrlEmail.clear();
                                  _ctrlSenha.clear();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SiginView()),
                                  );
                                },
                                child: Text(
                                  'Registre-se',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: fonte,
                                      color: corPrimaria,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          )
                        ])),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

