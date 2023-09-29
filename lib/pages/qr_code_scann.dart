import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRCodeScan extends StatefulWidget {
  const QRCodeScan({super.key});

  @override
  State<QRCodeScan> createState() => _QRCodeScanState();
}

class _QRCodeScanState extends State<QRCodeScan> {

  String? scanResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        centerTitle: true
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black
              ),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Scannen starten'),
              onPressed: scanBarcode,
            ),
            const SizedBox(height: 20,),
            Text(
              scanResult == null
              ? 'Scanne einen Code'
              :
              'Scan Ergebnis : $scanResult',
              style: const TextStyle(fontSize:  18),
            )
          ],
        ),
      )
    );
  }

  Future scanBarcode() async {
  String scanResult;
  try {
    scanResult = await FlutterBarcodeScanner.scanBarcode("#ff6666", "abbrechen", true, ScanMode.QR);
  } on PlatformException {
    scanResult = 'Fehlgeschlagen beim erhalten der Platform-version.';
  }
  if (!mounted) return;

  setState(() => this.scanResult = scanResult);  
  }
}

