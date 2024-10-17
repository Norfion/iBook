import 'dart:async';
import 'package:flutter/material.dart';
import 'login_view.dart'; 

class AnimacaoinicialView extends StatefulWidget {
  @override
  _AnimacaoinicialViewState createState() => _AnimacaoinicialViewState();
}

class _AnimacaoinicialViewState extends State<AnimacaoinicialView> {
  @override
  void initState() {
    super.initState();

    // Timer para navegar para a tela de login após 3 segundos
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Cor de fundo da splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png',
                width: 150), // Coloque sua imagem do logo
            SizedBox(height: 20),
            Text(
              'Nome do App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
