import 'package:flutter/material.dart';
import '../modelos/livro.dart';
import 'package:projeto_p1/main.dart';

class DetalhesTela extends StatelessWidget {
  final Livro livro;

  const DetalhesTela({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: corPrimaria, size: 40),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                livro.titulo,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: corPrimaria,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                livro.nomeAutor,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: corPrimaria.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    livro.urlCapa,
                                    width: 300,
                                    height: 450,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Sinopse:',
                                style:
                                    TextStyle(fontSize: 22, color: corPrimaria),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                livro.sinopse,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: corPrimaria),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          corTerciaria, // Cor de fundo preta corSecundaria,
                                      foregroundColor:
                                          corSecundaria, // Cor do texto branco
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // Cantos levemente arredondados
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 32.0)),
                                  child: Text('Adicionar ao carrinho',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: fonte)),
                                ),
                              )
                            ])))),
          ],
        ),
      ),
    );
  }
}
