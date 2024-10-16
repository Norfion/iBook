import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'view/login_view.dart';
import 'models/user_model.dart';

void main() {
  runApp(
      DevicePreview(enabled: true, builder: (context) => const MainApp()));
}

// Variaveis globais
var fonte = 'Roboto';
var corPrimaria = Color.fromRGBO(61, 66, 60, 1.0);
var corSecundaria = Color.fromRGBO(248, 244, 228, 1.0);
var corTerciaria = Color.fromRGBO(12, 165, 176, 1.0);
double? espacoEntreCampos = 10;

// Cadastros de usuários
List<Usuario> usuarios = [Usuario('Teste', 'teste@teste.com', '1234')];

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

