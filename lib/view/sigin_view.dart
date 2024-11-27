// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/funcoes.dart';

class SiginView extends StatefulWidget {
  const SiginView({super.key});

  @override
  State<SiginView> createState() => _SiginViewState();
}

class _SiginViewState extends State<SiginView> {
  // Configurações da tela
  final double? espacoTitulo = 70;

  // Controladores de TextFormField()
  final TextEditingController _ctrlNome = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlSenha = TextEditingController();

  // Validadores de Form()
  final _vlddRegistro = GlobalKey<FormState>();

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
                  topLeft: Radius.circular(60),
                ),
              ),
            ),
          ),
          // Elementos elevados sobre os fundos
          Positioned(
              top: MediaQuery.of(context).size.height * 0.025,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
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
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Crie uma conta para você!',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: corSecundaria,
                        fontFamily: fonte,
                      ),
                    ),
                    SizedBox(
                        height: espacoEntreCampos), // Espaçamento entre textos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Já tem uma conta? ',
                            style: TextStyle(
                                fontFamily: fonte, color: corSecundaria)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Entre por aqui',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: fonte,
                                color: corPrimaria,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40), // Espaçamento entre o texto e o campo
                    Form(
                        key: _vlddRegistro,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Nome', style: TextStyle(fontFamily: fonte)),
                            ],
                          ),
                          TextFormField(
                            controller: _ctrlNome,
                            style: TextStyle(fontSize: 20, fontFamily: fonte),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: corPrimaria, fontFamily: fonte),
                              labelText: 'Insira seu nome',
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .never, // Desativa o comportamento de flutuaçãoF
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: corPrimaria),
                              ),
                            ),
                            validator: (nome) {
                              final regex = RegExp(r'^[a-zA-Z\s]+$');
                              if (nome == null || nome.isEmpty) {
                                return 'Informe seu nome';
                              } else if (!(regex.hasMatch(nome))) {
                                return 'O nome deve ser composto apenas por letras';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: espacoEntreCampos),
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
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .never, // Desativa o comportamento de flutuação
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
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                              height:
                                  espacoEntreCampos), // Espaçamento entre os campos
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Senha',
                                  style: TextStyle(fontFamily: fonte)),
                            ],
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _ctrlSenha,
                            style: TextStyle(fontSize: 20, fontFamily: fonte),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: corPrimaria, fontFamily: fonte),
                              labelText: 'Crie uma senha',
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .never, // Desativa o comportamento de flutuação
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: corPrimaria),
                              ),
                            ),
                            validator: (senha) {
                              if (senha == null || senha.isEmpty) {
                                return 'Digite uma senha!';
                              }
                              // A senha deve estar entre 8 e 20 caracteres de comprimento
                              else if (!(senha.length >= 8)) {
                                return 'A senha deve ter no mínimo 8 caracteres';
                              } else if (!(senha.length <= 20)) {
                                return 'A senha deve ter no máximo 20 caracteres';
                              }
                              // A senha precisa ter pelo menos 1 letra maiuscula
                              else if (!(senha.contains(RegExp(r'[A-Z]')))) {
                                return 'A senha deve possuir 1 letra maiúscula';
                              }
                              // A senha precisa ter pelo menos 1 caracter especial
                              else if (!(senha.contains(
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]')))) {
                                return 'A senha deve possuir 1 caracter especial';
                              }
                              // A senha precisa ter pelo menos um número
                              else if (!(senha.contains(RegExp(r'\d')))) {
                                return 'A senha deve possuir um número';
                              }
                              // Verifica se há espaços em branco na senha
                              else if (senha.contains(RegExp(r'\s'))) {
                                return 'A senha não pode conter espaços!';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: espacoEntreCampos),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Confirmar senha',
                                  style: TextStyle(fontFamily: fonte)),
                            ],
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(fontSize: 20, fontFamily: fonte),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: corPrimaria, fontFamily: fonte),
                              labelText: 'Repita sua senha',
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .never, // Desativa o comportamento de flutuação
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: corPrimaria),
                              ),
                            ),
                            validator: (senhaConfirma) {
                              if (senhaConfirma == null ||
                                  senhaConfirma.isEmpty) {
                                return 'Repita a senha!';
                              } else if (senhaConfirma != _ctrlSenha.text) {
                                return 'As senhas não coincidem';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: espacoEntreCampos),
                          ElevatedButton(
                            onPressed: () async {
                              String nome = _ctrlNome.text.toString().trim();
                              String email = _ctrlEmail.text.toString().trim();
                              String senha = _ctrlSenha.text.toString().trim();

                              // Verifica se os dados inseridos são válidos
                              if (_vlddRegistro.currentState!.validate()) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: email, password: senha)
                                    .then((res) {
                                  //Armazenar informações adicionais no Firestore
                                  FirebaseFirestore.instance
                                      .collection('usuarios')
                                      .add({
                                    "uid": res.user!.uid.toString(),
                                    "nome": nome,
                                  });
                                  mostrarSnackBar(context,
                                      'Usuário criado com sucesso!', 2);
                                  esperarSegundos(5);
                                  Navigator.pop(context);
                                }).catchError((e) {
                                  switch (e.code) {
                                    case 'email-already-in-use':
                                      mostrarSnackBar(context,
                                          'O e-mail $email já está em uso.', 2);
                                      break;
                                    default:
                                      mostrarSnackBar(context,
                                          'Erro: ${e.code.toString()}', 2);
                                  }
                                });
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
                            child: Text('Registrar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    fontFamily: fonte)),
                          ),
                        ])),
                  ],
                )),
              )),
        ],
      ),
    );
  }
}
