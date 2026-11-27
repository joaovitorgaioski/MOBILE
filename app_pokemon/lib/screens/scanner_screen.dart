import 'package:app_pokemon/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool _navigating = false;

  Future<void> _onDetected(BarcodeCapture capture) async {
    if (_navigating || capture.barcodes.isEmpty) return;

    final int? id = int.tryParse(capture.barcodes.first.rawValue ?? '');
    if (id == null) return;

    _navigating = true;
    Vibration.vibrate(duration: 200);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(id: id)),
    );
    _navigating = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            spacing: 16,
            children: [
              Text(
                'Catálogo de Pokémons',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: MobileScanner(
                  controller: _scannerController,
                  onDetect: _onDetected,
                ),
              ),
              Icon(Icons.qr_code_scanner, color: Colors.white, size: 35),
              Text(
                'Aponte a câmera para o QR Code para destacar o Pokémon',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
