import 'dart:typed_data';
import 'dart:ui';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mycookbook_gemini/data/models/ocr_result.dart';
import 'package:mycookbook_gemini/domain/services/ocr_service.dart';

class MLKitOCRService implements OCRService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  @override
  Future<OCRResult> processImage(Uint8List imageBytes) async {
    final inputImage = InputImage.fromBytes(
      bytes: imageBytes,
      metadata: InputImageMetadata(
        size: const Size(0, 0),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: 0,
      ),
    );

    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    
    return OCRResult(rawText: recognizedText.text);
  }

  void dispose() {
    _textRecognizer.close();
  }
}
