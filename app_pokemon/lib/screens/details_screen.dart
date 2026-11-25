import 'package:app_pokemon/models/pokemon.dart';
import 'package:app_pokemon/services/api_service.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({super.key, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ApiService _service = ApiService();

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
        child: Card(
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
      ),
    );
  }
}
