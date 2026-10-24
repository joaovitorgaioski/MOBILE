import 'package:flutter/material.dart';

void main() {
  runApp(Truco());
}

class Truco extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: PlacarTruco(),
    );
  }
}

class PlacarTruco extends StatefulWidget {
  const new({super.key});

  @override
  State<PlacarTruco> createState() => _PlacarTrucoState();
}

class _PlacarTrucoState extends State<PlacarTruco> {
  String jogador1 = "Nós";
  String jogador2 = "Eles";
  int pontos1 = 0;
  int pontos2 = 0;
  int meta = 12;

  String? get vencedor {
    if (pontos1 >= meta) return jogador1;
    if (pontos2 >= meta) return jogador2;
    return null;
  }

  Future<void> _editarNome(int jogador) async {
    final controller = TextEditingController(
      text: jogador == 1 ? jogador1 : jogador2,
    );

    final novoNome = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar Nome"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: "Nome do Jogador"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text("Confirmar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
        ],
      ),
    );

    if (novoNome != null && novoNome.trim().isNotEmpty) {
      setState(() {
        jogador == 1 ? jogador1 = novoNome : jogador2 = novoNome;
      });
    }
  }

  void _reiniciar() {
    setState(() {
      pontos1 = 0;
      pontos2 = 0;
    });
  }

  void _adicionarPontos(int num, int pontos) {
    setState(() {
      num == 1 ? pontos1 += pontos : pontos2 += pontos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Placar de Truco",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _reiniciar,
            icon: Icon(Icons.refresh),
            tooltip: "Reiniciar Jogo",
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(child: _painelJogador(1)),
                Divider(
                  height: 20,
                  thickness: 5,
                  radius: BorderRadius.circular(20),
                ),
                Expanded(child: _painelJogador(2)),
              ],
            ),
          ),
          if (vencedor != null) _telaVitoria(),
        ],
      ),
    );
  }

  Widget _painelJogador(int num) {
    final pontos = num == 1 ? pontos1 : pontos2;
    final nome = num == 1 ? jogador1 : jogador2;
    final cor = num == 1 ? Colors.blue : Colors.red;

    return Card(
      color: cor.withValues(alpha: 0.8),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _editarNome(num),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Text(
                    nome,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.edit, size: 20),
                ],
              ),
            ),
            Text(
              "$pontos",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _adicionarPontos(num, 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cor,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  ),
                  child: Text(
                    "+1",
                    style: TextStyle(fontSize: 35, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _adicionarPontos(num, 3),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cor,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  ),
                  child: Text(
                    "+3",
                    style: TextStyle(fontSize: 35, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _telaVitoria() {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Card(
          margin: EdgeInsets.all(25),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                Icon(Icons.emoji_events, color: Colors.amber),
                Text(
                  "Vencedor!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  vencedor!,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _reiniciar,
                  label: Text("Jogar de novo"),
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
