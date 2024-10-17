import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'login_view.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  // Variáveis de controle e estilização
  double? tamIcone = 110.0;

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
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar ou ícone do perfil
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      usuarios[indiceUsuarioSelecionado].urlFotoPerfil_,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Nome do usuário
                  Text(
                    usuarios[indiceUsuarioSelecionado].nome,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: corPrimaria,
                      fontFamily: fonte,
                    ),
                  ),
                  Text(
                    usuarios[indiceUsuarioSelecionado].email,
                    style: TextStyle(
                      fontSize: 18,
                      color: corPrimaria,
                      fontFamily: fonte,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Informações adicionais do perfil
                  Card(
                    color: corTerciaria.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informações Pessoais',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: corPrimaria,
                              fontFamily: fonte,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Telefone: ${usuarios[indiceUsuarioSelecionado].telefone}',
                            style: TextStyle(
                              fontSize: 16,
                              color: corPrimaria,
                              fontFamily: fonte,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Endereço: ${usuarios[indiceUsuarioSelecionado].endereco}',
                            style: TextStyle(
                              fontSize: 16,
                              color: corPrimaria,
                              fontFamily: fonte,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Data de Nascimento: ${usuarios[indiceUsuarioSelecionado].dataNascimento}',
                            style: TextStyle(
                              fontSize: 16,
                              color: corPrimaria,
                              fontFamily: fonte,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 60),

                  // Botão de sair
                  ElevatedButton(
                    onPressed: () {
                      // Apaga os dados antes de sair

                      setState(() {
                        compras.livrosAdicionados
                            .clear(); // Remove todos os itens da lista
                        qtdLivrosCarrinho = 0;
                      });

                      // Remove todas as telas da pilha até voltar a tela de login
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginView()),
                          (Route<dynamic> route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: corTerciaria,
                      foregroundColor: corSecundaria,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                    ),
                    child: Text(
                      'Sair',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: fonte,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
