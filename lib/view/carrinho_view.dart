import 'package:flutter/material.dart';
import 'package:projeto_p1/models/livro_m.dart';
import 'package:projeto_p1/main.dart';

class CarrinhoView extends StatefulWidget {
  @override
  _CarrinhoViewState createState() => _CarrinhoViewState();
}

class _CarrinhoViewState extends State<CarrinhoView> {
  // Função para remover ou decrementar a quantidade do item
  void decrementarQuantidade(int index) {
    setState(() {
      final livro = compras.livrosAdicionados[index];
      if (livro.quantidade > 1) {
        livro.quantidade -= 1; // Decrementa a quantidade
      } else {
        compras.livrosAdicionados
            .removeAt(index); // Remove o item se a quantidade for 1
      }
    });
  }

  // Função para adicionar uma unidade ao item
  void incrementarQuantidade(int index) {
    setState(() {
      compras.livrosAdicionados[index].quantidade += 1;
    });
  }

  // Função para calcular o valor total
  double calcularValorTotal() {
    return compras.livrosAdicionados.fold(
        0, (total, livro) => total + (livro.getPreco() * livro.quantidade));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      appBar: AppBar(
        title: Text('Resumo de compras',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: corPrimaria,
              fontFamily: fonte,
            )),
        backgroundColor: corSecundaria,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:
            // Se não houver livros no carrinho, exibe uma mensagem
            compras.getQtdLivros() == 0
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
                        child:
                            // Lista de livros comprados
                            ListView.builder(
                          itemCount: compras.livrosAdicionados.length,
                          itemBuilder: (context, index) {
                            final livro = compras.livrosAdicionados[index];
                            final subTotal = livro.quantidade *
                                livro.getPreco(); // Calcula o subtotal

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                // Usamos uma coluna para agrupar o conteúdo e o rodapé
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        livro.getUrlCapa(),
                                        width: 60,
                                        height: 90,
                                        fit: BoxFit.cover,
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
                                                fontSize: 12,
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
                                      // Exibe a quantidade ao lado dos botões
                                      Text(
                                        '${livro.quantidade} un',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(width: 8),
                                      // Botão para remover ou decrementar a quantidade
                                      IconButton(
                                        icon: Icon(Icons.remove_circle,
                                            color: Colors.red),
                                        onPressed: () {
                                          decrementarQuantidade(index);
                                        },
                                      ),
                                      // Botão para adicionar mais uma unidade
                                      IconButton(
                                        icon: Icon(Icons.add_circle,
                                            color: Colors.green),
                                        onPressed: () {
                                          incrementarQuantidade(index);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          8), // Espaçamento entre o conteúdo e o rodapé
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .end, // Alinha o subtotal à direita
                                    children: [
                                      Text(
                                        'Subtotal: R\$ ${subTotal.toStringAsFixed(2)}', // Exibe o subtotal
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: corPrimaria,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                color: corTerciaria,
                              ),
                            ),
                            // Exibe o valor total atualizado
                            Text(
                              'R\$ ${calcularValorTotal().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: corPrimaria,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 20),

                      // Botão "Comprar"
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            compras.addLivro(livros[indiceLivroSelecionado]);

                            // Exibe uma mensagem de compra efetuada com sucesso
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
                                        Navigator.of(context)
                                            .pop(); // Fecha o diálogo
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );

                            // Limpa o carrinho após finalizar a compra
                            setState(() {
                              compras.livrosAdicionados
                                  .clear(); // Remove todos os itens da lista
                              qtdLivrosCarrinho = 0;
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
