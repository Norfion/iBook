import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'package:projeto_p1/models/livro_m.dart';
import '../controller/livro_controller.dart';
import 'detalhes_view.dart';
import '../controller/funcoes.dart';



class LivrosView extends StatefulWidget {
  const LivrosView({super.key});

  @override
  State<LivrosView> createState() => _LivrosViewState();
}

class _LivrosViewState extends State<LivrosView> {
  String generoSelecionado = '';
  List<Livro> livrosFiltrados = [];
  List<Livro> livros = [];
  List<String> generos = [
    'Romance',
    'Juvenil',
    'Ficção Científica',
    'Comédia',
    'Fantasia',
    'Autoajuda'
  ];
  late String idSelecionado;

  @override
  void initState() {
    super.initState();
    carregarLivros();
  }

  Future<void> carregarLivros() async {
    try {
      // Chama o método getLivros e atribui o retorno à variável livros
      List<Livro> livrosCarregados = await LivroController().getLivros();
      setState(() {
        livros = livrosCarregados;

        final random = Random();
        int indiceAleatorio = random
            .nextInt(generos.length + 1);

        filtrarLivros(generos[indiceAleatorio]);
      });
    } catch (error) {
      print("Erro ao carregar livros: $error");
    }
  }

  void filtrarLivros(String genero) {
    setState(() {
      generoSelecionado = genero;
      livrosFiltrados =
          livros.where((livro) => livro.generos.contains(genero)).toList();
    });
  }

  void selecionarLivro(String idSelecionado) {
    setState(() {
      for (int i = 0; i < livros.length; i++) {
        if (livros[i].id == idSelecionado) {
          livroSelecionado = livros[i];
        }
      }
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
              'Olá, ${usuarioLogado.nome}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: corPrimaria,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'O que vai ler hoje?',
              style: TextStyle(
                fontSize: 16,
                color: corTerciaria,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Pesquise o título do livro',
                filled: true,
                fillColor: corSecundaria.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.search, color: corTerciaria),
              ),
            ),
            SizedBox(height: 16),
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
                          color: corPrimaria,
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
                      Text(
                        '${generoSelecionado}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: corPrimaria,
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
                          color: corPrimaria,
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
                          ))
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
        onGeneroSelecionado(genero);
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: corTerciaria.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            genero,
            style: TextStyle(color: corTerciaria),
          ),
        ),
      ),
    );
  }
}

class CardLivro extends StatelessWidget {
  Livro livroConteudo;
  final Function(String) onLivroSelecionado;

  CardLivro({required this.livroConteudo, required this.onLivroSelecionado});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onLivroSelecionado(livroConteudo.id);
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
                  color: corPrimaria,
                ),
                textAlign: TextAlign.center),
            Text(
              livroConteudo.getNomeAutor(),
              style: TextStyle(color: corTerciaria),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
