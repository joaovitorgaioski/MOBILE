import 'package:flutter/material.dart';

void main() {
  runApp(PlacarTruco());
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

  void _editarNome() {}

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Placar de Truco"),
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
                  Divider(height: 20, thickness: 2),
                  Expanded(child: _painelJogador(2)),
                ],
              ),
            ),
          ],
        ),
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
              onTap: () => _editarNome(),
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
}
