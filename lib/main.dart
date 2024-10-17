import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'view/login_view.dart';
import 'models/user_model.dart';
import 'models/livro_m.dart';
import 'models/carrinho_m.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const MainApp()));
}

// Variaveis globais
var fonte = 'Roboto';
var corPrimaria = Color.fromRGBO(61, 66, 60, 1.0);
var corSecundaria = Color.fromRGBO(244, 244, 252, 1.0);
var corTerciaria = Color.fromRGBO(236, 84, 84, 1.0);
double? espacoEntreCampos = 10;
int indiceUsuarioSelecionado = 0;
int indiceLivroSelecionado = 0;
int qtdLivrosCarrinho = compras.getQtdLivros();

// Cadastros de usuários
List<Usuario> usuarios = [
  Usuario(
      'Norman',
      'norman@gmail.com',
      '12345',
      'R. Aristides Bernardes Barreto, 1125 - Jardim Marchesi',
      '21/05/2003',
      '(16) 98162-6831',
      'perfil/norman_fotoPerfil.jpg'),
  Usuario('Teste', 'teste@teste.com', '1234', 'R. Teste, 0 - Jardim Teste',
      '01/02/1990', '(16) 99999-9999', ''),
];

// Cadastro de livros
List<Livro> livros = [
  Livro(
      'O apanhador no campo de centeio',
      'J. D. Salinger',
      ['Romance', 'Juvenil'],
      1951,
      '978-6580309030',
      'É Natal, e Holden Caulfield conseguiu ser expulso de mais uma escola. Com uns trocados da venda de uma máquina de escrever e portando seu indefectível boné vermelho de caçador, o jovem traça um plano incerto: tomar um trem para Nova York e vagar por três dias pela grande cidade, adiando a volta à casa dos pais até que eles recebam a notícia da expulsão por alguém da escola. Seus dias e noites serão marcados por encontros confusos, e ocasionalmente comoventes, com estranhos, brigas com os tipos mais desprezíveis, encontros com ex-namoradas, visitas à sua irmã Phoebe -- a única criatura neste mundo que parece entendê-lo -- e por dúvidas que irão consumi-lo durante sua estadia, entre elas uma questão recorrente: afinal, para onde vão os patos do Central Park no inverno? Acima de todos esses fatos, preocupações e pensamentos, paira a inimitável voz de Holden, o adolescente raivoso e idealista que quer desbancar o mundo dos "fajutos", num turbilhão quase sem fim de ressentimento, humor, frases lapidares, insegurança, bravatas e rebelião juvenil.',
      53.12,
      4.2,
      'capas/o-apanhador-no-campo-de-centeio.jpg'),
  Livro(
      '1984',
      'George Orwell',
      ['Fantasia'],
      1949,
      '978-6587435183',
      'Winston Smith, número 6079, ocupa uma função comum no Departamento de Documentação: “retificar” fatos de acordo com as orientações do Ministério da Verdade. E ele não mede esforços em seu objetivo de erradicar, em todos os níveis, quaisquer elementos que ameacem sua existência. A individualidade, o livre-arbítrio, o pensamento crítico, o amor – todos considerados transgressões inadmissíveis – são punidos com o máximo de rigor e severidade. Nada escapa aos olhos do Grande Irmão, o grande líder do regime, e é por meio de sua vigilância intensiva, cujos “olhos eram capazes de o seguir (…) em moedas, estampas, capas de livros, bandeiras, pôsteres e invólucros de pacotes de cigarro”, que o regime se certifica milimetricamente da soberania de seu poder. Por outro lado, Winston se sente ávido por conhecer algum tipo de liberdade. Assim, pouco a pouco avança em seus atos de resistência em busca de reavivar sua humanidade, obliterada por décadas da repressão política incidente no mais profundo nível de seus pensamentos e lembranças. Entretanto, para realizar seu desejo ele precisará desviar cuidadosamente de um perigoso campo minado sob o escrutínio do Partido e do Grande Irmão.',
      69.90,
      4.8,
      'capas/1984.jpg'),
  Livro(
      'O problema dos 3 corpos',
      "Qxin",
      ['Ficção Científica'],
      2008,
      '978-8556510204',
      'China, final dos anos 1960. Enquanto o país inteiro está sendo devastado pela violência da Revolução Cultural, um pequeno grupo de astrofísicos, militares e engenheiros começa um projeto ultrassecreto envolvendo ondas sonoras e seres extraterrestres. Uma decisão tomada por um desses cientistas mudará para sempre o destino da humanidade e, cinquenta anos depois, uma civilização alienígena a beira do colapso planeja uma invasão. O problema dos três corpos é uma crônica da marcha humana em direção aos confins do universo. Uma clássica história de ficção científica, no melhor estilo de Arthur C. Clarke. Um jogo envolvente em que a humanidade tem tudo a perder.',
      51.94,
      4.7,
      'capas/o-problema-dos-3-corpos.jpg'),
  Livro(
      'A floresta sombira',
      'Qxin Liu',
      ['Ficção Científica'],
      2008,
      '978-8556510501',
      'Depois de "O problema dos três corpos", a humanidade se prepara para a iminente invasão alienígena. A Organização Terra-Trissolaris ― formada por habitantes da Terra que traíram seus iguais para se associar aos alienígenas ― pode ter sido derrotada, mas a presença de partículas subatômicas, os sófons, revela todo o conhecimento da humanidade para os invasores, e as defesas terráqueas são um livro aberto para os trissolarianos. Nesse contexto, em que só a mente humana é segura, é montado o Projeto Barreiras: quatro pessoas serão encarregadas de pensar em uma estratégia para a salvação do mundo. A Barreira está completamente isolada, protegendo seus pensamentos do restante da humanidade, mas até que ponto é possível guardar um segredo?',
      65.59,
      4.8,
      'capas/a-floresta-sombria.jpg'),
  Livro(
      'O fim da morte',
      'Qxin Liu',
      ['Ficção Científica'],
      2010,
      '978-8556510747',
      'Meio século se passou desde a Batalha do Fim do Mundo, e a Terra conquistou um frágil acordo para manter os invasores trissolarianos encurralados. Com ele, uma nova era de paz e prosperidade tem início, e Luo Ji ― o homem que elaborou o acordo, agora conhecido como Portador da Espada ― tem que carregar nas costas a vida de duas civilizações. Enquanto isso, Cheng Xin, uma engenheira aeroespacial do início do século XXI, desperta da hibernação nessa nova época. Luo Ji está velho, e um novo Portador da Espada deve tomar seu lugar. Será que Cheng Xin é capaz de suportar a responsabilidade de manter a Terra em segurança? E por que um antigo projeto, da época da Crise Trissolariana, não sai de sua mente? O destino da humanidade está em jogo ― estará nosso destino nas estrelas, ou permaneceremos no berço de nossa civilização até o fim?',
      71.01,
      4.8,
      'capas/o-fim-da-morte.jpg'),
  Livro(
      'A biblioteca da meia-noite',
      'Matt Haig',
      ['Drama', 'Autoajuda'],
      2021,
      '978-6558380542',
      'os 35 anos, Nora Seed é uma mulher cheia de talentos e poucas conquistas. Arrependida das escolhas que fez no passado, ela vive se perguntando o que poderia ter acontecido caso tivesse vivido de maneira diferente. Após ser demitida e seu gato ser atropelado, Nora vê pouco sentido em sua existência e decide colocar um ponto final em tudo. Porém, quando se vê na Biblioteca da Meia-Noite, Nora ganha uma oportunidade única de viver todas as vidas que poderia ter vivido. Neste lugar entre a vida e a morte, e graças à ajuda de uma velha amiga, Nora pode, finalmente, se mudar para a Austrália, reatar relacionamentos antigos – ou começar outros –, ser uma estrela do rock, uma glaciologista, uma nadadora olímpica... enfim, as opções são infinitas. Mas será que alguma dessas outras vidas é realmente melhor do que a que ela já tem? Em A Biblioteca da Meia-Noite , Nora Seed se vê exatamente na situação pela qual todos gostaríamos de poder passar: voltar no tempo e desfazer algo de que nos arrependemos. Diante dessa possibilidade, Nora faz um mergulho interior viajando pelos livros da Biblioteca da Meia-Noite até entender o que é verdadeiramente importante na vida e o que faz, de fato, com que ela valha a pena ser vivida.',
      41.93,
      4.7,
      'capas/a-biblioteca-da-meia-noite.jpg')
];

// Carrinho de compras

Carrinho compras = Carrinho([]);

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginView(),
      },
    );
  }
}
