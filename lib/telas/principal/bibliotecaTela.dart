import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_p1/controladores/usuarioControlador.dart';
import 'package:projeto_p1/main.dart';
import '../../controladores/livroControlador.dart';
import '../../modelos/livro.dart';
import '../detalhesTela.dart';

class BibliotecaTela extends StatefulWidget {
  const BibliotecaTela({super.key});

  @override
  State<BibliotecaTela> createState() => _BibliotecaTelaState();
}

class _BibliotecaTelaState extends State<BibliotecaTela> {
  late Livro livroSelecionado;
  String nomeUsuario = '';

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

  @override
  void initState() {
    super.initState();
    carregarLivros();
    carregarNomeUsuario(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> carregarLivros() async {
    try {
      List<Livro> livrosCarregados = await LivroControlador().getLivros();
      setState(() {
        livros = livrosCarregados;
        if (livros.isNotEmpty) {
          final random = Random();
          int indiceAleatorio = random.nextInt(generos.length);
          filtrarLivros(generos[indiceAleatorio]);
        }
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

  Future<void> carregarNomeUsuario(String uidUsuario) async {
    try {
      String nomeUsuarioCarregado =
          await UsuarioControlador.getNomeUsuarioUID(uidUsuario);
      setState(() {
        nomeUsuario = nomeUsuarioCarregado;
      });
    } catch (error) {
      print("Erro ao carregar nome do usuário: $error");
    }
  }

  void selecionarLivro(Livro livro) {
    setState(() {
      livroSelecionado = livro;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesTela(livro: livroSelecionado),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, $nomeUsuario',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: corPrimaria,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'O que vai ler hoje?',
                  style: TextStyle(
                    fontSize: 16,
                    color: corTerciaria,
                  ),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16)
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Parte scrollável
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Gêneros',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: corPrimaria,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: generos
                            .map((genero) => CardGenero(
                                  genero: genero,
                                  onGeneroSelecionado: filtrarLivros,
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      generoSelecionado.isNotEmpty
                          ? generoSelecionado
                          : 'Selecione um gênero',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: corPrimaria,
                      ),
                    ),
                    const SizedBox(height: 16),
                    livrosFiltrados.isNotEmpty
                        ? SizedBox(
                            height: 300,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: livrosFiltrados
                                  .map((livro) => CardLivro(
                                        livroConteudo: livro,
                                        onLivroSelecionado: selecionarLivro,
                                      ))
                                  .toList(),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Nenhum livro de $generoSelecionado encontrado.',
                              style: TextStyle(color: corPrimaria),
                            ),
                          ),
                    const SizedBox(height: 16),
                    Text(
                      'Nossa biblioteca',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: corPrimaria,
                      ),
                    ),
                    const SizedBox(height: 16),
                    livros.isNotEmpty
                        ? SizedBox(
                            height: 300,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: livros
                                  .map((livro) => CardLivro(
                                        livroConteudo: livro,
                                        onLivroSelecionado: selecionarLivro,
                                      ))
                                  .toList(),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Nenhum livro disponível na biblioteca.',
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardGenero extends StatelessWidget {
  final String genero;
  final ValueChanged<String> onGeneroSelecionado;

  const CardGenero({
    super.key,
    required this.genero,
    required this.onGeneroSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onGeneroSelecionado(genero);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
  final Livro livroConteudo;
  final ValueChanged<Livro> onLivroSelecionado;

  const CardLivro({
    super.key,
    required this.livroConteudo,
    required this.onLivroSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onLivroSelecionado(livroConteudo);
        livroSelecionado = livroConteudo;
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                livroConteudo.urlCapa,
                width: 144,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              livroConteudo.titulo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: corPrimaria,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              livroConteudo.nomeAutor,
              style: TextStyle(color: corTerciaria),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
