import 'package:app_cep/model/endereco.dart';
import 'package:app_cep/service/viacep_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cepController = TextEditingController();
  final ViacepService _service = ViacepService();

  Endereco? _endereco;
  String? _erroMensagem;

  Future<void> _buscarCep() async {
    setState(() {
      _endereco = null;
      _erroMensagem = null;
    });

    try {
      final endereco = await _service.buscarCep(_cepController.text);
      setState(() {
        _endereco = endereco;
      });
    } catch (e) {
      setState(() {
        _erroMensagem = e.toString().replaceFirst("Exception: ", "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscador de CEP"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP",
                hintText: "Ex: 99888123",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.pin_drop),
              ),
            ),
            ElevatedButton(
              onPressed: _buscarCep,
              child: Text("Buscar Endereço", style: TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
              ),
            ),
            Expanded(child: _buildResultArea()),
          ],
        ),
      ),
    );
  }

  Widget _buildResultArea() {
    if (_erroMensagem != null) {
      return Center(
        child: Column(
          spacing: 20,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 50),
            Text(
              _erroMensagem!,
              style: TextStyle(color: Colors.red, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (_endereco != null) {
      return Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(_endereco!.cep),
                Text(_endereco!.logradouro),
                Text(_endereco!.localidade),
                Text(_endereco!.uf),
                Text(_endereco!.bairro),
                Text(_endereco!.complemento),
              ],
            ),
          ),
        ),
      );
    }

    return Center(
      child: Text(
        "Digite um CEP para consultar.",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
