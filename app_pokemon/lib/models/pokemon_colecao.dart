class PokemonColecao {
  final int id;
  final String nome;
  final DateTime dataCaptura;

  PokemonColecao({
    required this.id,
    required this.nome,
    required this.dataCaptura,
  });

  // Na atividade dizia explicitamente para salvar os campos id, nome e data_captura, então achei melhor fazer um model para representar pokemons guardados
  factory PokemonColecao.fromMap(Map<String, dynamic> map) {
    return PokemonColecao(
      id: map['id'],
      nome: map['nome'],
      dataCaptura: DateTime.parse(map['data_captura']),
    );
  }
}
