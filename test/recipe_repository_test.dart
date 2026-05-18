import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/data/repositories/recipe_repository_impl.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late RecipeRepositoryImpl repository;

  setUp(() {
    // Используем In-Memory базу данных для тестов
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = RecipeRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Добавление и получение рецепта', () async {
    final recipe = RecipeData(
      id: const Uuid().v4(),
      title: 'Тестовый рецепт',
      language: 'ru',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isDeleted: false,
      isShared: false,
    );

    await repository.addRecipe(recipe);
    final recipes = await repository.getRecipes();

    expect(recipes.length, 1);
    expect(recipes.first.title, 'Тестовый рецепт');
  });
}
