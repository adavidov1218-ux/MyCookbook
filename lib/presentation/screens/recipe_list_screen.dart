import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mycookbook_gemini/presentation/providers/recipe_provider.dart';
import 'package:mycookbook_gemini/presentation/screens/recipe_detail_screen.dart';
import 'package:mycookbook_gemini/presentation/screens/recipe_form_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  void initState() {
    super.initState();
    // Load recipes when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().loadRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои рецепты'),
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.recipes.isEmpty) {
            return const Center(child: Text('Рецептов пока нет.'));
          }
          return ListView.builder(
            itemCount: provider.recipes.length,
            itemBuilder: (context, index) {
              final recipe = provider.recipes[index];
              return ListTile(
                title: Text(recipe.title),
                subtitle: Text(recipe.cuisine ?? 'Кухня не указана'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipeId: recipe.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecipeFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
