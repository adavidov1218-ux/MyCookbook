import 'dart:typed_data';
import 'package:mycookbook_gemini/data/models/ocr_result.dart';
import 'package:mycookbook_gemini/domain/services/ocr_service.dart';

class MockOCRService implements OCRService {
  @override
  Future<OCRResult> processImage(Uint8List imageBytes) async {
    // Simulate OCR processing delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Return a mock result
    return OCRResult(rawText: "Mock OCR Result: 1. Mix ingredients\n2. Cook for 20 mins.");
  }
}
