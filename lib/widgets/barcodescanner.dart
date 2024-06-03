import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shopsquad/theme/colors.dart';

class Barcodescanner extends StatefulWidget {
  final Function(String) onBarcodeScanned;

  const Barcodescanner({super.key, required this.onBarcodeScanned});

  @override
  State<Barcodescanner> createState() => _BarcodescannerState();
}

class _BarcodescannerState extends State<Barcodescanner> {
  static const IconData scannerIcon = IconData(0xefe1, fontFamily: 'MaterialIcons');

  Future<void> scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Farbe des Scanner-Overlays
        'Abbrechen', // Text des Abbrechen-Buttons
        true, // Zeige Blitz-Symbol an
        ScanMode.BARCODE, // Modus auf Barcode gesetzt
      );
    } catch (e) {
      scanResult = 'Fehler beim Scannen';
    }

    if (!mounted) return;

    widget.onBarcodeScanned(scanResult);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: scanBarcode,
      icon: Icon(
        scannerIcon,
        color: AppColors.white,
      ),
    );
  }
}
