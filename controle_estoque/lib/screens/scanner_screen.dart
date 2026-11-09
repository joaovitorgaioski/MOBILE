import 'package:controle_estoque/models/item.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  String? _errorMessage;

  void _onDetected(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;

    if (barcodes.isEmpty) return;

    final Barcode barcode = barcodes.first;

    if (barcode == null) return;

    final String? rawValue = barcode.rawValue;

    try {
      final Item item = Item.fromJson(rawValue!);
    } catch (e) {
      setState(() {
        _errorMessage = "QR Code Inválido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Escanear produto")),
      body: Stack(
        children: [
          MobileScanner(controller: _scannerController, onDetect: _onDetected),
          if (_errorMessage != null)
            Container(
              color: Colors.red.withAlpha(50),
              alignment: Alignment.center,
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
        ],
      ),
    );
  }
}
