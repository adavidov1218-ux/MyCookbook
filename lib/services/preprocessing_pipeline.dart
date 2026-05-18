import 'package:mycookbook_gemini/domain/services/source_preprocessing_pipeline.dart';

class YouTubePreprocessingPipeline implements SourcePreprocessingPipeline {
  static final _junkRegex = RegExp(r'(http|www|подпис|лайк|telegram|instagram|gmail|#|реклама|скидк|видео|о канале)', caseSensitive: false);
  static final _timestampRegex = RegExp(r'\d{1,2}:\d{2}');

  @override
  PreprocessedResult process(String rawText) {
    String text = _cleanSource(rawText);
    final noise = _filterNoise(text);
    text = _removeNoise(text, noise);
    final metadata = _stripMetadata(text);
    text = _normalizeSegments(text);

    return PreprocessedResult(
      cleanedRecipeText: text,
      extractedMetadata: metadata,
      removedNoise: noise.join('\n'),
    );
  }

  String _cleanSource(String text) {
    text = text.replaceAll('\r', '').replaceAll('\u00A0', ' ');
    // Remove bullet symbols from line starts
    final lines = text.split('\n');
    final cleanedLines = lines.map((line) {
      return line.replaceAll(RegExp(r'^[\s•●▪◦○■□]+'), '');
    }).toList();
    return cleanedLines.join('\n');
  }

  List<String> _filterNoise(String text) {
    return text.split('\n').where((line) => _junkRegex.hasMatch(line)).toList();
  }

  String _removeNoise(String text, List<String> noise) {
    return text.split('\n').where((line) => !noise.contains(line)).join('\n');
  }

  Map<String, dynamic> _stripMetadata(String text) {
    return {'timestamps': _timestampRegex.allMatches(text).map((m) => m.group(0)).toList()};
  }

  String _normalizeSegments(String text) {
    return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }
}
