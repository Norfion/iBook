import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';

class DetalhesView extends StatefulWidget {
  const DetalhesView({super.key});

  @override
  State<DetalhesView> createState() => _DetalhesViewState();
}

class _DetalhesViewState extends State<DetalhesView> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão de voltar
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: corPrimaria, size: 40),
              onPressed: () {
                Navigator.pop(context); // Volta para a tela anterior
              },
            ),
            SizedBox(height: 20),

            // Título
            Text(
              livroSelecionado.titulo,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: corPrimaria,
              ),
            ),
            SizedBox(height: 5),

            // Autor
            Text(
              livroSelecionado.nomeAutor,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: corPrimaria.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagem da capa do livroSelecionado
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            livroSelecionado
                                .getUrlCapa(), // Caminho da imagem do livroSelecionado
                            width: 200,
                            height: 340,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Preço
                      Text(
                        'R\$ ${livroSelecionado.preco!.toStringAsFixed(2)}', // Exibe o preço formatado
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Sinopse
                      Text(
                        'Sinopse',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: corPrimaria,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        livroSelecionado.sinopse,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: corPrimaria.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Botão "Adicionar ao carrinho"
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            compras.addLivro(livroSelecionado);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Livro adicionado ao seu carrinho'),
                              duration: Duration(seconds: 3),
                            ));
                          },
                          label: Text('Adicionar ao carrinho'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: corPrimaria,
                            foregroundColor: corSecundaria,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
