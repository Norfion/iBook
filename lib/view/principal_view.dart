import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import 'package:projeto_p1/view/livros_view.dart';
import 'perfil_view.dart';
import 'carrinho_view.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  double tamFonteTag = 14;
  int _selectedIndex = 0;
  int qtdLivros = 0;

  // Lista de telas
  final List<Widget> _telas = [
    LivrosView(),
    CarrinhoView(),
    PerfilView(),
  ];

  // Atualiza o índice
  // Será usado no Rodapé
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      body: _telas[_selectedIndex],
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
                Container(
                  child: compras.getQtdLivros() == 0
                      ? null
                      : Positioned(
                          right: 0,
                          left: 15,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              '${qtdLivrosCarrinho}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: tamFonteTag,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            activeIcon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: corTerciaria),
                Container(
                  child: compras.getQtdLivros() == 0
                      ? null
                      : Positioned(
                          right: 0,
                          left: 15,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              '${compras.getQtdLivros()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: tamFonteTag,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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
