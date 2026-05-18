import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/domain/services/youtube_service.dart';
import 'package:mycookbook_gemini/services/recipe_ingestion_orchestrator.dart';
import 'package:uuid/uuid.dart';

class YouTubeServiceImpl implements YouTubeService {
  final RecipeIngestionOrchestrator _orchestrator = RecipeIngestionOrchestrator();

  static final _playerResponseRegex = RegExp(
    r'var ytInitialPlayerResponse\s*=\s*(\{.*?\});',
    dotAll: true,
  );

  String _normalizeUrl(String url) {
    if (url.isEmpty) throw FormatException('Invalid URL');
    String videoId = "";
    if (url.contains('v=')) {
      videoId = url.split('v=').last.split('&').first;
    } else if (url.contains('youtu.be/')) {
      videoId = url.split('youtu.be/').last.split('?').first;
    } else if (url.contains('shorts/')) {
      videoId = url.split('shorts/').last.split('?').first;
    }
    if (videoId.isEmpty || videoId.length < 8) throw FormatException('Invalid YouTube URL');
    return "https://www.youtube.com/watch?v=$videoId";
  }

  @override
  Future<RecipeData?> getRecipeInfoFromUrl(String url) async {
    try {
      final normalizedUrl = _normalizeUrl(url);
      final response = await http.get(
        Uri.parse(normalizedUrl),
        headers: {
          'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
          'Accept-Language': 'ru-RU,ru;q=0.9',
        },
      );

      if (response.statusCode != 200) return null;
      if (response.body.contains('consent.youtube.com')) throw Exception('Consent Required');

      final match = _playerResponseRegex.firstMatch(response.body);
      if (match == null) return null;

      final data = jsonDecode(match.group(1)!);
      final videoDetails = data['videoDetails'];
      final microformat = data['microformat'];

      String title = videoDetails?['title']?.toString() ?? 'Рецепт из видео';
      String desc = videoDetails?['shortDescription']?.toString() ?? '';
      if (desc.isEmpty) {
        desc = microformat?['playerMicroformatRenderer']?['description']?['simpleText']?.toString() ?? '';
      }

      final recipe = _orchestrator.orchestrate(
        rawText: desc,
        fallbackTitle: title,
      );

      return RecipeData(
        id: const Uuid().v4(),
        title: recipe.title,
        language: 'ru',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isDeleted: false,
        isShared: false,
        ingredients: recipe.ingredients.map((e) => e.toString()).join('\n'),
        steps: recipe.steps.map((e) => e.description).join('\n'),
        youtubeUrl: normalizedUrl,
        notes: "Оригинал: ${recipe.rawText}", 
      );
    } catch (e) {
      print('DEBUG: Ingestion Error: $e');
      return null;
    }
  }
}
