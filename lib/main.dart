// Framework e Firebase
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:projeto_p1/firebase_options.dart';

// Tela de login
import 'telas/autenticacao/entrarTela.dart';

// Modelos e Controladores
import './modelos/livro.dart';
import './modelos/pedido.dart';
import './modelos/usuario.dart';

// Variaveis globais
var fonte = 'Roboto';
var corPrimaria = Color.fromRGBO(61, 66, 60, 1.0);
var corSecundaria = Color.fromRGBO(244, 244, 252, 1.0);
var corTerciaria = Color.fromRGBO(236, 84, 84, 1.0);
double? espacoEntreCampos = 10;

Livro? livroSelecionado;
Pedido? pedido;
Usuario? usuario;

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview(enabled: true, builder: (context) => const MainApp()));
}

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
        '/login': (context) => EntrarTela(),
      },
    );
  }
}
