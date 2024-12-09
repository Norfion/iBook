import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_p1/main.dart';
import '../../controladores/usuarioControlador.dart';
import '../autenticacao/entrarTela.dart';
import '../../modelos/usuario.dart';


class PerfilTela extends StatefulWidget {
  const PerfilTela({super.key});

  @override
  State<PerfilTela> createState() => _PerfilTelaState();
}

class _PerfilTelaState extends State<PerfilTela> {
  double? tamIcone = 110.0;

  @override
  void initState() {
    super.initState();
    carregarUsuario(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> carregarUsuario(String uidUsuario) async {
    try {
      Usuario? usuarioCarregado =
          await UsuarioControlador().getUsuario(uidUsuario);
      setState(() {
        usuario = usuarioCarregado;
      });
    } catch (error) {
      print("Erro ao carregar usuário: $error");
      setState(() {
      });
    }
  }

  bool eValidaUrlImagem(String palavra, List<String> trechos) {
    for (int i = 0; i < trechos.length; i++) {
      if (palavra.contains(trechos[i])) {
        return true;
      }
    }
    print('URL da imagem não reconhecida');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (usuario == null) {
      // Mensagem para o caso de o usuário não ser encontrado
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            "Usuário não encontrado",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: corTerciaria,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            color: corTerciaria,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.67,
              decoration: BoxDecoration(
                color: corSecundaria,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(90),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: (usuario!.urlFotoPerfil_ == null ||
                            usuario!.urlFotoPerfil_!.isEmpty ||
                            !eValidaUrlImagem(usuario!.urlFotoPerfil_!,
                                ['.png', '.jpg', '.jpeg', '.gif', '.bmp']))
                        ? Container(
                            width: (tamIcone! + 60),
                            height: (tamIcone! + 60),
                            decoration: BoxDecoration(
                              color: corTerciaria,
                              border: Border.all(
                                color: corSecundaria,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(Icons.auto_stories,
                                size: tamIcone, color: corSecundaria),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              usuario!.urlFotoPerfil_!,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    usuario!.nome,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: corPrimaria,
                      fontFamily: fonte,
                    ),
                  ),
                  Text(
                    usuario!.email,
                    style: TextStyle(
                      fontSize: 18,
                      color: corPrimaria,
                      fontFamily: fonte,
                    ),
                  ),
                  // const SizedBox(height: 24),
                  // Card(
                  //   color: corTerciaria.withOpacity(0.3),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           'Informações Pessoais',
                  //           style: TextStyle(
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold,
                  //             color: corPrimaria,
                  //             fontFamily: fonte,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 250),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const EntrarTela()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: corTerciaria,
                      foregroundColor: corSecundaria,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                    ),
                    child: Text(
                      'Sair',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: fonte,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
