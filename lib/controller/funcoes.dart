import 'package:flutter/material.dart';

void mostrarSnackBar(
    BuildContext context, String mensagem, int duracaoSegundos) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagem),
      duration: Duration(seconds: duracaoSegundos),
    ),
  );
}

void esperarSegundos(int duracaoSegundos) async {
  await Future.delayed(Duration(seconds: duracaoSegundos));
}
