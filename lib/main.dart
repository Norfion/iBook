import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:projeto_p1/firebase_options.dart';

// Tela de login
import 'view/login_view.dart';

// Modelos e classes
import 'models/user_model.dart';
import 'models/livro_m.dart';
import 'models/carrinho_m.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview(enabled: true, builder: (context) => const MainApp()));
}

// Variaveis globais
var fonte = 'Roboto';
var corPrimaria = Color.fromRGBO(61, 66, 60, 1.0);
var corSecundaria = Color.fromRGBO(244, 244, 252, 1.0);
var corTerciaria = Color.fromRGBO(236, 84, 84, 1.0);
double? espacoEntreCampos = 10;
int indiceLivroSelecionado = 0;
int qtdLivrosCarrinho = compras.getQtdLivros();

// Salva na memória qual usuário está logado
Usuario usuarioLogado = Usuario('', '', '');

// Carrinho de compras

Carrinho compras = Carrinho([]);

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
        '/login': (context) => LoginView(),
      },
    );
  }
}
