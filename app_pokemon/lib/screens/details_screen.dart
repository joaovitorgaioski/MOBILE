import 'package:app_pokemon/database/database_helper.dart';
import 'package:app_pokemon/models/pokemon.dart';
import 'package:app_pokemon/models/pokemon_colecao.dart';
import 'package:app_pokemon/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vibration/vibration.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ApiService _service = ApiService();
  DatabaseHelper db = DatabaseHelper();

  Pokemon? _pokemon;
  String? _erroMensagem;
  bool _carregando = true;

  Future<void> _carregarPokemon() async {
    try {
      final pokemon = await _service.buscarPokemon(widget.id);

      setState(() {
        _pokemon = pokemon;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _erroMensagem = "Não foi possível carregar. $e";
        _carregando = false;
      });
    }
  }

  void _inserirPokemon() {
    db.inserir(_pokemon!);
    Vibration.vibrate(duration: 200);
  }

  Future<List<PokemonColecao>> _obterPokemons() async {
    return await db.obterTodos();
  }

  @override
  void initState() {
    super.initState();
    _carregarPokemon();
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return Scaffold(
        appBar: AppBar(title: Text('Pokémon'), centerTitle: true),
        body: Center(child: CircularProgressIndicator(color: Colors.red)),
      );
    }

    if (_erroMensagem != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Erro'), centerTitle: true),
        body: Center(child: Text(_erroMensagem!)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: Text('Pokémon Encontrado!'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(24),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    Image.network(
                      _pokemon!.sprite,
                      height: 250,
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      _pokemon!.nome.toUpperCase(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text('ID: ${_pokemon!.id}', style: TextStyle(fontSize: 18)),
                    Text(
                      'Altura: ${_pokemon!.altura}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: _inserirPokemon,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Adicionar à coleção"),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return _modalColecao();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                  child: Text("Ver coleção"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Voltar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _modalColecao() {
    return FutureBuilder<List<PokemonColecao>>(
      future: _obterPokemons(),
      builder: (_, snapshot) {
        final pokemons = snapshot.data ?? [];

        if (pokemons.isEmpty) {
          return Center(child: Text("A coleção esta vazia."));
        }

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: pokemons.length,
          itemBuilder: (_, i) {
            final p = pokemons[i];

            return Card(
              elevation: 2,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.red.shade50,
                  child: Icon(Icons.catching_pokemon, color: Colors.red),
                ),
                title: Text(
                  p.nome.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red.shade900,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text("ID: ${p.id}"),
                    Text("Capturado em: ${p.dataCaptura}"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
