import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'package:projeto_p1/models/livro_m.dart';
import 'package:projeto_p1/main.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  String generoSelecionado = '';
  List<Livro> livrosFiltrados = [];

  void filtrarLivros(String genero) {
    setState(() {
      generoSelecionado = genero;
      livrosFiltrados =
          livros.where((livro) => livro.getGenero() == genero).toList();
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
                      genero: 'Romance', onGeneroSelecionado: filtrarLivros),
                  CardGenero(
                      genero: 'Aventura', onGeneroSelecionado: filtrarLivros),
                  CardGenero(
                      genero: 'Fantasia', onGeneroSelecionado: filtrarLivros),
                  CardGenero(
                      genero: 'História', onGeneroSelecionado: filtrarLivros),
                  CardGenero(
                      genero: 'Filosofia', onGeneroSelecionado: filtrarLivros),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 290,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: livrosFiltrados
                    .map((livro) => CardLivro(livroConteudo: livro))
                    .toList(),
              ),
            ),
            Text('Biblioteca completa'),
            SizedBox(height: 16),
            Container(
              height: 290,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: livros
                    .map((livro) => CardLivro(livroConteudo: livro))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: corTerciaria),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: corPrimaria),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: corPrimaria),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: corTerciaria,
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

  CardLivro({required this.livroConteudo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              livroConteudo.getUrlCapa(),
              width: 144,
              height: 220,
              fit: BoxFit.cover,
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
