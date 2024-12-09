

import 'dart:math';

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

int gerarNumeroAleatorio(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1); // Inclui o limite superior (max)
}