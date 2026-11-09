import 'dart:convert';

class Item {
  final String nome;
  final int qtd;
  final double valor;

  Item({required this.nome, required this.qtd, required this.valor});

  factory Item.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Item(
      nome: data['nome'] ?? 'Sem nome',
      qtd: data['qtd'] ?? 0,
      valor: (data['valor'] ?? 0).toDouble()
    );
  }

  double get totalItem => qtd * valor;


}