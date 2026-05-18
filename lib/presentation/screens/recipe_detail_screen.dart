import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/core/widgets/status_handler.dart';
import 'package:mycookbook_gemini/presentation/providers/recipe_provider.dart';
import 'package:mycookbook_gemini/presentation/screens/recipe_form_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  Future<void> _deleteRecipe(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить рецепт?'),
        content: const Text('Это действие нельзя отменить.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Отмена')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (!context.mounted) return;
      await context.read<RecipeProvider>().deleteRecipe(recipeId);
      if (!context.mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return StreamBuilder<RecipeData?>(
      stream: (db.select(db.recipes)..where((t) => t.id.equals(recipeId))).watchSingleOrNull(),
      builder: (context, snapshot) {
        final recipe = snapshot.data;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(recipe?.title ?? 'Рецепт'),
            actions: [
              if (recipe != null) ...[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeFormScreen(recipeId: recipe.id),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteRecipe(context),
                ),
              ],
            ],
          ),
          body: StatusHandler(
            isLoading: snapshot.connectionState == ConnectionState.waiting,
            isEmpty: !snapshot.hasData,
            emptyMessage: 'Рецепт не найден',
            child: recipe != null
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (recipe.cuisine != null && recipe.cuisine!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Chip(
                              label: Text(recipe.cuisine!),
                              backgroundColor: Colors.blueGrey.shade100,
                            ),
                          ),
                        Text(
                          recipe.title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (recipe.youtubeUrl != null && recipe.youtubeUrl!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: InkWell(
                              onTap: () async {
                                final Uri url = Uri.parse(recipe.youtubeUrl!);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Не удалось открыть ссылку')),
                                    );
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.play_circle_fill, color: Colors.red),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      recipe.youtubeUrl!,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const Divider(),
                        Text(
                          'Ингредиенты',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recipe.ingredients ?? 'Не указаны',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Приготовление',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recipe.steps ?? 'Описание приготовления смотри на видео',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Дата добавления: ${recipe.createdAt.toLocal().toString().split('.')[0]}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
