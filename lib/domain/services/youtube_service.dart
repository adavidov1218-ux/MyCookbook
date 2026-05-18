import 'package:mycookbook_gemini/data/database/database.dart';

abstract class YouTubeService {
  Future<RecipeData?> getRecipeInfoFromUrl(String url);
}
