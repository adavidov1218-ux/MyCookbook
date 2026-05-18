import 'package:flutter/material.dart';
import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/domain/repositories/recipe_repository.dart';

class RecipeProvider with ChangeNotifier {
  RecipeRepository _repository;

  RecipeProvider(this._repository);

  void updateRepository(RecipeRepository repository) {
    _repository = repository;
  }

  List<RecipeData> _recipes = [];
  bool _isLoading = false;

  List<RecipeData> get recipes => _recipes;
  bool get isLoading => _isLoading;

  Future<void> loadRecipes() async {
    _isLoading = true;
    notifyListeners();

    _recipes = await _repository.getRecipes();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addRecipe(RecipeData recipe) async {
    await _repository.addRecipe(recipe);
    await loadRecipes();
  }

  Future<void> updateRecipe(RecipeData recipe) async {
    await _repository.updateRecipe(recipe);
    await loadRecipes();
  }

  Future<void> deleteRecipe(String id) async {
    await _repository.deleteRecipe(id);
    await loadRecipes();
  }
}
