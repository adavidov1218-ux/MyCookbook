abstract class SourcePreprocessingPipeline {
  PreprocessedResult process(String rawText);
}

class PreprocessedResult {
  final String cleanedRecipeText;
  final Map<String, dynamic> extractedMetadata;
  final String removedNoise;

  PreprocessedResult({
    required this.cleanedRecipeText,
    required this.extractedMetadata,
    required this.removedNoise,
  });
}
