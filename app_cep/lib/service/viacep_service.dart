import 'dart:convert';

import 'package:app_cep/model/endereco.dart';
import 'package:http/http.dart' as http;

class ViacepService {
  static const String _baseURL = 'viacep.com.br';

  Future<Endereco> buscarCep(String cep) async {
    final cepLimpo = cep.replaceAll(RegExp(r'\D'), '');

    if (cepLimpo.length != 8) throw Exception("O CEP deve ter 8 caracteres");

    final Uri url = Uri.https(_baseURL, 'ws/$cepLimpo/json');

    try {
      final response = await http.get(url);

      if(response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if(jsonData.containsKey('error') && jsonData.containsKey('error') == true);

        return Endereco.fromJson(jsonData);
      }

      throw Exception("Erro de requisição: ${response.statusCode}");
    } catch(e) {
      throw Exception("Falha ao conectar ao servidor: $e");
    }
  }
}