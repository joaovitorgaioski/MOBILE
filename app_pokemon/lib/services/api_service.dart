import 'package:app_pokemon/models/pokemon.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseURL = 'pokeapi.co';

  Future<Pokemon> buscarPokemon(int id) async {
    final Uri url = Uri.https(_baseURL, "api/v2/pokemon/$id/");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Pokemon.fromJson(response.body);
    }

    throw Exception("Erro de requisição: ${response.statusCode}");
  }
}
