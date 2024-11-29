import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';

class CarrinhoView extends StatefulWidget {
  final Function(int) onCarrinhoUpdated;  // Callback para atualizar a quantidade

  CarrinhoView({required this.onCarrinhoUpdated});

  @override
  _CarrinhoViewState createState() => _CarrinhoViewState();
}

class _CarrinhoViewState extends State<CarrinhoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Resumo de compras',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: corPrimaria,
            fontFamily: fonte,
          ),
        ),
        backgroundColor: corSecundaria,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: compras.getQtdLivros() == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ops! Seu carrinho está vazio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: corPrimaria,
                        fontFamily: fonte,
                      ),
                    ),
                    Text(
                      'Adicione livros ao seu carrinho para que apareçam aqui!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: corPrimaria,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: compras.getQtdItens(),
                      itemBuilder: (context, index) {
                        final livro = compras.itens[index].livro;
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      livro.getUrlCapa(),
                                      width: 80,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          livro.getTitulo(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: corTerciaria,
                                          ),
                                        ),
                                        Text(
                                          '${livro.getNomeAutor()}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: corPrimaria,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'R\$ ${livro.getPreco().toStringAsFixed(2)} / un',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: corPrimaria,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  IconButton(
                                    icon:
                                        Icon(Icons.remove, color: corPrimaria),
                                    onPressed: () {
                                      setState(() {
                                        compras.removerLivro(livro);
                                        widget.onCarrinhoUpdated(compras.getQtdLivros());
                                      });
                                    },
                                  ),
                                  Text(
                                    '${compras.itens[index].quantidade}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: corPrimaria,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: corPrimaria),
                                    onPressed: () {
                                      setState(() {
                                        compras.addLivro(livro);
                                        widget.onCarrinhoUpdated(compras.getQtdLivros());
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: corPrimaria,
                          ),
                        ),
                        Text(
                          'R\$ ${compras.getValorTotal().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: corTerciaria,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Pedido finalizado'),
                              content: Text(
                                  'Sua compra foi finalizada com sucesso! Agradecemos a preferência\n\nEm breve lhe enviaremos um e-mail com os detalhes do seu pedido'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );

                        setState(() {
                          for(int i = compras.itens.length -1; i >= 0; i--){
                            compras.itens.removeAt(i);
                          }
                        });
                      },
                      label: Text('Finalizar compra'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: corPrimaria,
                        foregroundColor: corSecundaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 32.0,
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
      ),
    );
  }
}
