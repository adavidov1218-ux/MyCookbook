class OCRResult {
  final String rawText;
  // Potentially add structured fields later, e.g., List<String> ingredients, List<String> steps
  // For now, keeping it simple as per initial spec.

  OCRResult({required this.rawText});

  // TODO: Add toJson and fromJson methods for persistence/serialization
}
