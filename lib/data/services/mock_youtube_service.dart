import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/domain/services/youtube_service.dart';
import 'package:uuid/uuid.dart';

class MockYouTubeService implements YouTubeService {
  @override
  Future<RecipeData?> getRecipeInfoFromUrl(String url) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return a mock recipe
    return RecipeData(
      id: const Uuid().v4(),
      title: "Mock YouTube Recipe",
      language: "ru",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isDeleted: false,
      isShared: false,
      rawText: "This is a mock recipe description from YouTube.",
      youtubeUrl: url,
    );
  }
}
