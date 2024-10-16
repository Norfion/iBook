// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_p1/models/user_model.dart';
import 'package:projeto_p1/main.dart';

class SiginView extends StatefulWidget {
  const SiginView({super.key});

  @override
  State<SiginView> createState() => _SiginViewState();
}

class _SiginViewState extends State<SiginView> {
  // Configurações da tela
  final double? espacoTitulo = 70;

  // Controladores de TextFormField()
  TextEditingController _ctrlNome = TextEditingController();
  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlSenha = TextEditingController();

  // Validadores de Form()
  final _vlddRegistro = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrimaria,
      body: Stack(
        children: [
          // Terço superior com fundo preto
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            color: corPrimaria,
          ),
          // Dois terços inferiores com fundo branco e bordas arredondadas
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.90,
              decoration: BoxDecoration(
                color: corSecundaria,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
            ),
          ),
          // Elementos elevados sobre os fundos
          Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: corPrimaria,
                          iconSize: 40, // Seta de voltar
                          onPressed: () {
                            Navigator.pop(context); // Retorna à tela anterior
                          },
                        ),
                      ],
                    )),
                    Text(
                      'Crie uma conta para você!',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: corPrimaria,
                        fontFamily: fonte,
                      ),
                    ),
                    SizedBox(
                        height: espacoEntreCampos), // Espaçamento entre textos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Já tem uma conta? ',
                            style: TextStyle(fontFamily: fonte)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Entre por aqui',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: fonte,
                                color: corTerciaria,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Espaçamento entre o texto e o campo
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

                              bool emailJaCadastrado = false;

                              // Verifica se o e-mail já está sendo usado
                              for (int i = 0; i < usuarios.length; i++) {
                                if (usuarios[i].email == email) {
                                  emailJaCadastrado = true;
                                  break;
                                }
                              }

                              if (email == null || email.isEmpty) {
                                return 'Informe seu e-mail';
                              } else if (!regExp.hasMatch(email)) {
                                return 'E-mail inválido';
                              } else if (emailJaCadastrado) {
                                return 'Este e-mail já está sendo usado!';
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
                              String nome = _ctrlNome.text.trim();
                              String email = _ctrlEmail.text.trim();
                              String senha = _ctrlSenha.text.trim();

                              // Verifica se os dados inseridos são válidos
                              if (_vlddRegistro.currentState!.validate()) {
                                // Cria um novo usuário
                                usuarios.add(Usuario(nome, email, senha));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Seu cadastro foi criado com sucesso! Estamos te redirecionando para a página de login... Aguarde'),
                                  duration: Duration(seconds: 8),
                                ));

                                // Limpa as entradas de dados
                                _ctrlNome.clear();
                                _ctrlEmail.clear();
                                _ctrlSenha.clear();

                                // Espera um pouco para redirecionar
                                await Future.delayed(Duration(seconds: 8));

                                // Volta para a tela de login
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: corPrimaria, // Cor de fundo preta corSecundaria,
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
