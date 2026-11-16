import 'package:app_pokemon/models/pokemon.dart';
import 'package:app_pokemon/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController _scannerController = MobileScannerController();
  Pokemon? pokemon;
  String? _errorMessage;

  void _onDetected(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;

    if (barcodes.isEmpty) return;

    final Barcode barcode = barcodes.first;

    final String? rawValue = barcode.rawValue;

    try {
      pokemon = Pokemon.fromJson(rawValue!);
      debugPrint(pokemon.toString());
      debugPrint(rawValue);
    } catch (e) {
      setState(() {
        _errorMessage = "QR Code Inválido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(controller: _scannerController, onDetect: _onDetected),
          if (pokemon != null) DetailsScreen(),
        ],
      ),
    );
  }
}
