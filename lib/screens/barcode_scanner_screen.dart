import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:meal_up/components/camera_view.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key, required this.onResult});

  final Function(Barcode result) onResult;

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  List<Barcode> barcodes = [];
  bool _canProcess = true;
  bool _isBusy = false;

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      onImage: _processImage,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    if (barcodes.isEmpty) {
      barcodes = await _barcodeScanner.processImage(inputImage);
      if (inputImage.metadata?.size != null &&
          inputImage.metadata?.rotation != null) {
        if (barcodes.isNotEmpty) {
          widget.onResult(barcodes[0]);
          if (!mounted) return;
          Navigator.pop(context);
        }
      }
    }
    _isBusy = false;
  }
}
