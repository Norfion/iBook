import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String nome;
  String email;
  String? urlFotoPerfil_;

  Usuario({required this.nome, required this.email, this.urlFotoPerfil_});

  factory Usuario.fromDocumento(DocumentSnapshot<Object?> documento) {
    return Usuario(
        nome: documento['nome'] ?? "",
        email: documento['email'] ?? "",
        urlFotoPerfil_: documento['urlFotoPerfil'] ?? "");
  }
}
