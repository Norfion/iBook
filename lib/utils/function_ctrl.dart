import 'package:projeto_p1/models/user_model.dart';

// Retorna:
//         0 - caso a senha esteja incorreta
//         1 - caso a senha esteja correta
//         2 - caso o usuário, por meio do e-mail, não seja encontrado
int validateUser(List<Usuario> usuarios, String email, String senha) {
  int userPosition = -1;

  // Procura o usuário na lista de usuários através do e-mail
  for (int i = 0; i < usuarios.length; i++) {
    if (usuarios[i].email == email) {
      userPosition = i;
      break;
    }
  }

  if (userPosition == -1) {
    return 2;
  }
  // Após achar o usuário, verifica se a senha é válida
  
  if (usuarios[userPosition].senha == senha) {
    return 1;
  } else {
    return 0;
  }
}
