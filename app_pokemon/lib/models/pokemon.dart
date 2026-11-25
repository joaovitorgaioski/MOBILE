import 'dart:convert';

class Pokemon {
  final int id;
  final String nome;
  final double altura;
  final String sprite;

  Pokemon({
    required this.id,
    required this.nome,
    required this.altura,
    required this.sprite,
  });

  factory Pokemon.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);

    return Pokemon(
      id: data['id'],
      nome: data['name'],
      altura: (data['height'] as num).toDouble(),
      sprite: data['sprites']['front_default'],
    );
  }
}
