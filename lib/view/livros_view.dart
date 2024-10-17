import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'package:projeto_p1/models/livro_m.dart';
import 'package:projeto_p1/main.dart';
import 'detalhes_view.dart';
import 'perfil_view.dart';

class LivrosView extends StatefulWidget {
  const LivrosView({super.key});

  @override
  State<LivrosView> createState() => _LivrosViewState();
}

class _LivrosViewState extends State<LivrosView> {
  String generoSelecionado = 'Ficção Científica';
  List<Livro> livrosFiltrados = [];

  // Seta os livros para um gênero inicialmente, para que a tela de livros
  // não fique em branco aguardadno a interação do usuário
  @override
  void initState() {
    super.initState();
    filtrarLivros(generoSelecionado);
  }

  // Cria a lista de livros filtrados
  // Será usado no CardLivro
  void filtrarLivros(String genero) {
    setState(() {
      generoSelecionado = genero;
      livrosFiltrados =
          livros.where((livro) => livro.generos.contains(genero)).toList();
    });
  }

  // Altera o indice do livro selecionado
  // Será usado no CardLivro
  void selecionarLivro(int indice) {
    setState(() {
      indiceLivroSelecionado = indice; // Altera o índice do livro selecionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Olá, ${usuarios[indiceUsuarioSelecionado].nome}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: corTerciaria,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'O que vai ler hoje?',
              style: TextStyle(
                fontSize: 16,
                color: corPrimaria,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Pesquise o título do livro',
                filled: true,
                fillColor: Color(0xFFE0F7FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search, color: corPrimaria),
              ),
            ),
            SizedBox(height: 16),

            /// Parte da tela que é rolável
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gêneros',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: corTerciaria,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CardGenero(
                                genero: 'Ficção Científica',
                                onGeneroSelecionado: filtrarLivros),
                            CardGenero(
                                genero: 'Romance',
                                onGeneroSelecionado: filtrarLivros),
                            CardGenero(
                                genero: 'Juvenil',
                                onGeneroSelecionado: filtrarLivros),
                            CardGenero(
                                genero: 'Fantasia',
                                onGeneroSelecionado: filtrarLivros),
                            CardGenero(
                                genero: 'Autoajuda',
                                onGeneroSelecionado: filtrarLivros),
                            CardGenero(
                                genero: 'Comédia',
                                onGeneroSelecionado: filtrarLivros),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 290,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: livrosFiltrados
                              .map((livro) => CardLivro(
                                  livroConteudo: livro,
                                  onLivroSelecionado: selecionarLivro))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nossa biblioteca',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: corTerciaria,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 290,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: livros
                              .map((livro) => CardLivro(
                                  livroConteudo: livro,
                                  onLivroSelecionado: selecionarLivro))
                              .toList(),
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardGenero extends StatelessWidget {
  final String genero;
  final ValueChanged<String> onGeneroSelecionado;

  CardGenero({required this.genero, required this.onGeneroSelecionado});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onGeneroSelecionado(genero); // Executa a função callback ao clicar
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFE0F7FA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            genero,
            style: TextStyle(color: corPrimaria),
          ),
        ),
      ),
    );
  }
}

class CardLivro extends StatelessWidget {
  Livro livroConteudo;
  final Function(int) onLivroSelecionado;

  CardLivro({required this.livroConteudo, required this.onLivroSelecionado});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Seta qual livro foi selecionado
        onLivroSelecionado(livros.indexOf(livroConteudo));

        // Abre a página de detalhes
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetalhesView()),
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                livroConteudo.getUrlCapa(),
                width: 144,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(livroConteudo.getTitulo(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: corTerciaria, // Cor 4
                ),
                textAlign: TextAlign.center),
            Text(
              livroConteudo.getNomeAutor(),
              style: TextStyle(color: corPrimaria),
              textAlign: TextAlign.right, // Cor 3
            ),
          ],
        ),
      ),
    );
  }
}
