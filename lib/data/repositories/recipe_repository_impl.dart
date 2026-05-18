import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/domain/repositories/recipe_repository.dart';
import 'package:drift/drift.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final AppDatabase _database;

  RecipeRepositoryImpl(this._database);

  @override
  Future<List<RecipeData>> getRecipes() async {
    return await _database.select(_database.recipes).get();
  }

  @override
  Future<RecipeData?> getRecipeById(String id) async {
    return await (_database.select(_database.recipes)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<String> addRecipe(RecipeData recipe) async {
    await _database.into(_database.recipes).insert(recipe);
    return recipe.id;
  }

  @override
  Future<void> updateRecipe(RecipeData recipe) async {
    await (_database.update(_database.recipes)..where((t) => t.id.equals(recipe.id)))
        .write(recipe);
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await (_database.delete(_database.recipes)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<RecipeData>> searchRecipes(String query) async {
    return await (_database.select(_database.recipes)
      ..where((t) => t.title.like('%$query%')))
        .get();
  }

  @override
  Future<void> setFavorite(String id, bool isFavorite) async {
    // Note: 'isFavorite' is not currently in the recipe table schema.
    // If we want to support this, we need to add the column and migrate.
    // Implementing this as a placeholder or to be added to the schema.
    throw UnimplementedError('isFavorite column not in schema yet');
  }
}
