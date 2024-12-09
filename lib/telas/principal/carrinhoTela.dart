import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import '../../controladores/pedidoControlador.dart';
import '../../modelos/pedido.dart';

class CarrinhoTela extends StatefulWidget {
  final Function(int) onCarrinhoUpdated;

  const CarrinhoTela({super.key, required this.onCarrinhoUpdated});

  @override
  _CarrinhoTelaState createState() => _CarrinhoTelaState();
}

class _CarrinhoTelaState extends State<CarrinhoTela> {
  @override
  void initState() {
    super.initState();
    carregarPedido();
  }

  Future<void> carregarPedido() async {
    // Substitua 'uidUsuario' pelo UID do usuário autenticado
    String uidUsuario = "usuario_autenticado_uid";
    PedidoControlador pedidoControlador = PedidoControlador();

    try {
      Pedido novoPedido = await pedidoControlador.getPedido(uidUsuario);
      setState(() {
        pedido = novoPedido;
      });
    } catch (e) {
      print("Erro ao carregar o pedido: $e");
    }
  }

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
      body: pedido == null
          ? Center(
              child: CircularProgressIndicator(color: corPrimaria),
            )
          : pedido!.getQuantidade() == 0
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
                        itemCount: pedido!.itens.length,
                        itemBuilder: (context, index) {
                          final item = pedido!.itens[index];
                          final livro = item.livro;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(0),
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
                                      child: Image.network(
                                        livro.urlCapa,
                                        width: 80,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            livro.titulo,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: corTerciaria,
                                            ),
                                          ),
                                          Text(
                                            livro.nomeAutor,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: corPrimaria,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'R\$ ${livro.preco.toStringAsFixed(2)} / un',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: corPrimaria,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: Icon(Icons.remove,
                                          color: corPrimaria),
                                      onPressed: () {
                                        setState(() {
                                          if (item.quantidade > 1) {
                                            item.quantidade--;
                                          } else {
                                            pedido!.itens.removeAt(index);
                                          }
                                          widget.onCarrinhoUpdated(
                                              pedido!.getQuantidade());
                                        });
                                      },
                                    ),
                                    Text(
                                      '${item.quantidade}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: corPrimaria,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add, color: corPrimaria),
                                      onPressed: () {
                                        setState(() {
                                          item.quantidade++;
                                          widget.onCarrinhoUpdated(
                                              pedido!.getQuantidade());
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
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
                            'R\$ ${pedido!.getValorTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: corTerciaria,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pedido finalizado'),
                                content: const Text(
                                    'Sua compra foi finalizada com sucesso! Agradecemos a preferência\n\nEm breve lhe enviaremos um e-mail com os detalhes do seu pedido'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );

                          setState(() {
                            pedido!.itens.clear();
                          });
                        },
                        label: const Text('Finalizar compra'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: corPrimaria,
                          foregroundColor: corSecundaria,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
    );
  }
}
