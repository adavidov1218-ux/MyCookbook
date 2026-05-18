import 'package:mycookbook_gemini/data/database/database.dart';

abstract class RecipeRepository {
  Future<List<RecipeData>> getRecipes();
  Future<RecipeData?> getRecipeById(String id);
  Future<String> addRecipe(RecipeData recipe);
  Future<void> updateRecipe(RecipeData recipe);
  Future<void> deleteRecipe(String id);
  Future<List<RecipeData>> searchRecipes(String query);
  Future<void> setFavorite(String id, bool isFavorite);
}
