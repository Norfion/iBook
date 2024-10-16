import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:projeto_p1/view/principal_view.dart';
import 'view/login_view.dart';
import 'models/user_model.dart';
import 'models/livro_m.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const MainApp()));
}

// Variaveis globais
var fonte = 'Roboto';
var corPrimaria = Color.fromRGBO(61, 66, 60, 1.0);
var corSecundaria = Color.fromRGBO(248, 244, 228, 1.0);
var corTerciaria = Color.fromRGBO(12, 165, 176, 1.0);
double? espacoEntreCampos = 10;
int indiceUsuarioSelecionado = 0;

// Cadastros de usuários
List<Usuario> usuarios = [Usuario('Teste', 'teste@teste.com', '1234')];

// Cadastro de livros
List<Livro> livros = [
  Livro(
      'O apanhador no campo de centeio',
      'J. D. Salinger',
      'Romance',
      1951,
      '...',
      'sinopse',
      53.12,
      4.2,
      'images/capas/o-apanhador-no-campo-de-centeio.jpg'),
  Livro('1984', 'George Orwell', 'Fantasia', 1949, '...', '...', 69.90, 4.8,
      'images/capas/1984.jpg'),
  Livro('O problema dos 3 corpos', "Qxin", 'Ficção Científica', 2008, '...',
      '...', 51.94, 4.7, 'images/capas/o-problema-dos-3-corpos.jpg'),
  Livro('A floresta sombira', 'Qxin Liu', 'Ficção Científica', 2008, '...',
      '...', 65.59, 4.8, 'images/capas/a-floresta-sombria.jpg'),
  Livro('O fim da morte', 'Qxin Liu', 'Ficção Científica', 2010, '...', '...',
      71.01, 4.8, 'images/capas/o-fim-da-morte.jpg')
];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => PrincipalView(),
      },
    );
  }
}
