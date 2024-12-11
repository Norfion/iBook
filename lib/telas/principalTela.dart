// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'package:projeto_p1/telas/principal/bibliotecaTela.dart';
import '../controladores/pedidoControlador.dart';
import '../controladores/usuarioControlador.dart';
import '../modelos/pedido.dart';
import '../modelos/usuario.dart';
import 'principal/perfilTela.dart';
import 'principal/carrinhoTela.dart';

// Variaveis globais
Pedido? pedido;
Usuario? usuario;
ValueNotifier<int> qtdLivrosNotifier =
    ValueNotifier<int>(pedido?.getQuantidade() ?? 0);

class PrincipalTela extends StatefulWidget {
  const PrincipalTela({super.key});

  @override
  State<PrincipalTela> createState() => _PrincipalTelaState();
}

class _PrincipalTelaState extends State<PrincipalTela> {
  double tamFonteTag = 14;
  int _selectedIndex = 0;
  bool carregando = true;

  // Lista de telas
  late List<Widget> telas;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await carregarUsuario(currentUser.uid);
      await carregarPedido(currentUser.uid);
    }
    setState(() {
      telas = [
        const BibliotecaTela(),
        const Carrinhotela(),
        const PerfilTela(),
      ];
      carregando = false;
    });
  }

  Future<void> carregarPedido(String uidUsuario) async {
    await carregarUsuario(uidUsuario);
    try {
      Pedido? pedidoCarregado = await PedidoControlador().getPedido(uidUsuario);
      setState(() {
        pedido = pedidoCarregado;
      });

      qtdLivrosNotifier.value =
          pedido?.getQuantidade() ?? 0; // Atualiza o ValueNotifier
    } catch (error) {
      print("Erro ao carregar pedido: $error");
    }
  }

  Future<void> carregarUsuario(String uidUsuario) async {
    try {
      Usuario? usuarioCarregado = await UsuarioControlador()
          .getUsuario(FirebaseAuth.instance.currentUser!.uid.toString());
      if (usuarioCarregado != null) {
        setState(() {
          usuario = usuarioCarregado;
        });
      }
    } catch (error) {
      print("Erro ao carregar usuário: $error");
    }
  }

  // Atualiza o índice
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      body: carregando
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: corPrimaria),
                const SizedBox(height: 30),
                Text(
                  'Carregando...',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: corPrimaria,
                  ),
                )
              ],
            ))
          : telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: corPrimaria),
            activeIcon: Icon(Icons.book, color: corTerciaria),
            label: 'Livros',
          ),
          BottomNavigationBarItem(
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: corPrimaria),
                ValueListenableBuilder<int>(
                  valueListenable: qtdLivrosNotifier,
                  builder: (context, value, child) {
                    return value > 0
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: const BoxConstraints(
                                minWidth: 12, minHeight: 12),
                            child: Text(
                              '$value',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: tamFonteTag,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox(); // Esconde o badge se o valor for 0
                  },
                ),
              ],
            ),
            activeIcon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: corTerciaria),
                ValueListenableBuilder<int>(
                  valueListenable: qtdLivrosNotifier,
                  builder: (context, value, child) {
                    return value > 0
                        ? Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: const BoxConstraints(
                                minWidth: 12, minHeight: 12),
                            child: Text(
                              '$value',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: tamFonteTag,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox(); // Esconde o badge se o valor for 0
                  },
                ),
              ],
            ),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: corPrimaria),
            activeIcon: Icon(Icons.person, color: corTerciaria),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: corTerciaria,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
