import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'login_view.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Text(
              'Esse é seu perfil!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: corTerciaria,
              ),
            ),
            // Nome do usuário
            Text(
              'Nome do Usuário',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: corTerciaria,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'João Silva', // Exemplo de nome
              style: TextStyle(
                fontSize: 20,
                color: corTerciaria,
              ),
            ),
            SizedBox(height: 20),

            // E-mail do usuário
            Text(
              'E-mail',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: corTerciaria,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'joao.silva@email.com', // Exemplo de e-mail
              style: TextStyle(
                fontSize: 20,
                color: corTerciaria,
              ),
            ),
            SizedBox(height: 30),
            // Informações adicionais
            Divider(color: corTerciaria), // Divisor
            SizedBox(height: 10),
            Text(
              'Informações Adicionais:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: corTerciaria,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Data de nascimento: 01/01/2000',
              style: TextStyle(fontSize: 16, color: corTerciaria),
            ),
            SizedBox(height: 5),
            Text(
              'Endereço: Rua Exemplo, 123, Cidade, Estado',
              style: TextStyle(fontSize: 16, color: corTerciaria),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
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
                    backgroundColor: corPrimaria,
                    foregroundColor: corSecundaria,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)),
                child: Text('Sair'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
