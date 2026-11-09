import 'dart:ui';

import 'package:controle_estoque/models/item.dart';
import 'package:controle_estoque/screens/scanner_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _itens = [];

  void _openScanner() async {
    final Item? newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScannerScreen()),
    );

    if (newItem != null) {
      setState(() {
        _itens.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor de Estoque'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          // Card de Resumo
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.deepPurple.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryBox('Itens Escaneados', '0'),
                _buildSummaryBox('Qtd. Total', '0'),
                _buildSummaryBox('Valor Total', '0'),
              ],
            ),
          ),

          // Lista de Itens
          Expanded(
            child: _itens.isEmpty
                ? Center(child: Text('Nenhum produto escaneado'))
                : ListView.builder(
                    itemCount: _itens.length,
                    itemBuilder: (context, index) {
                      final item = _itens[index];

                      return ListTile(
                        leading: Icon(
                          Icons.inventory_2,
                          color: Colors.deepPurple,
                        ),
                        title: Text(item.nome),
                        subtitle: Text(
                          'Qtd: ${item.qtd} | Unit: R\$ ${item.valor.toStringAsFixed(2)}',
                        ),
                        trailing: Text(
                          'R\$ ${item.totalItem.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openScanner,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        icon: Icon(Icons.qr_code_scanner, color: Colors.amberAccent),
        label: Text('Escanear'),
      ),
    );
  }

  Widget _buildSummaryBox(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
