import 'dart:typed_data';

import 'package:mycookbook_gemini/data/models/ocr_result.dart';

abstract class OCRService {
  Future<OCRResult> processImage(Uint8List imageBytes);
}
