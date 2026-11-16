import 'dart:convert';

class Pokemon {
  final int id;
  final String nome;
  final String sprite;

  Pokemon({required this.id, required this.nome, required this.sprite});

  factory Pokemon.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);

    return Pokemon(id: data['id'], nome: data['nome'], sprite: data['sprite']);
  }
}
