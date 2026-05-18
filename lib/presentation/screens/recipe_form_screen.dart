import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycookbook_gemini/data/database/database.dart';
import 'package:mycookbook_gemini/presentation/providers/recipe_provider.dart';
import 'package:mycookbook_gemini/data/services/mlkit_ocr_service.dart';
import 'package:mycookbook_gemini/data/services/youtube_service_impl.dart';

class RecipeFormScreen extends StatefulWidget {
  final String? recipeId;
  const RecipeFormScreen({super.key, this.recipeId});

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _cuisineController = TextEditingController();
  final _youtubeController = TextEditingController();
  
  final _ocrService = MLKitOCRService();
  final _ytService = YouTubeServiceImpl();
  final _picker = ImagePicker();

  bool _isLoading = false;
  RecipeData? _existingRecipe;

  @override
  void initState() {
    super.initState();
    if (widget.recipeId != null) {
      _loadRecipe();
    }
  }

  Future<void> _loadRecipe() async {
    final db = context.read<AppDatabase>();
    _existingRecipe = await (db.select(db.recipes)..where((t) => t.id.equals(widget.recipeId!))).getSingleOrNull();
    if (_existingRecipe != null) {
      _titleController.text = _existingRecipe!.title;
      _ingredientsController.text = _existingRecipe!.ingredients ?? '';
      _stepsController.text = _existingRecipe!.steps ?? '';
      _cuisineController.text = _existingRecipe!.cuisine ?? '';
      _youtubeController.text = _existingRecipe!.youtubeUrl ?? '';
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _isLoading = true);
      final bytes = await file.readAsBytes();
      final result = await _ocrService.processImage(bytes);
      _ingredientsController.text = result.rawText;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _parseYouTube() async {
    final url = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Вставьте YouTube URL'),
          content: TextField(controller: controller),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('OK')),
          ],
        );
      },
    );

    if (url != null && url.isNotEmpty) {
      setState(() => _isLoading = true);
      final recipe = await _ytService.getRecipeInfoFromUrl(url);
      
      if (recipe != null) {
        print("DEBUG UI: Ingredients count: ${recipe.ingredients?.length ?? 0}");
        print("DEBUG UI: Steps count: ${recipe.steps?.length ?? 0}");
        
        setState(() {
          _titleController.text = recipe.title;
          _ingredientsController.text = recipe.ingredients ?? 'Не найдено';
          _stepsController.text = recipe.steps ?? 'Не найдено';
          _youtubeController.text = url;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Не удалось извлечь рецепт из ссылки')),
          );
        }
      }
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = RecipeData(
        id: widget.recipeId ?? const Uuid().v4(),
        title: _titleController.text.length > 100 ? _titleController.text.substring(0, 100) : _titleController.text,
        language: 'ru',
        createdAt: _existingRecipe?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        isDeleted: false,
        isShared: false,
        ingredients: _ingredientsController.text,
        steps: _stepsController.text,
        cuisine: _cuisineController.text,
        youtubeUrl: _youtubeController.text,
      );
      
      if (widget.recipeId == null) {
        if (!mounted) return;
        await context.read<RecipeProvider>().addRecipe(recipe);
      } else {
        if (!mounted) return;
        await context.read<RecipeProvider>().updateRecipe(recipe);
      }
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipeId == null ? 'Новый рецепт' : 'Редактировать')),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Название'),
                      validator: (val) => val!.isEmpty ? 'Введите название' : null,
                    ),
                    TextFormField(
                      controller: _cuisineController,
                      decoration: const InputDecoration(labelText: 'Кухня'),
                    ),
                    TextFormField(
                      controller: _youtubeController,
                      decoration: const InputDecoration(labelText: 'YouTube ссылка'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _ingredientsController,
                      decoration: const InputDecoration(labelText: 'Рецепт (Ингредиенты и порции)'),
                      maxLines: 5,
                    ),
                    TextFormField(
                      controller: _stepsController,
                      decoration: const InputDecoration(labelText: 'Приготовление'),
                      maxLines: 10,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: _pickImage, child: const Text('Сканировать фото (OCR)')),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: _parseYouTube, child: const Text('YouTube ссылка')),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: _saveRecipe, child: const Text('Сохранить')),
                  ],
                ),
              ),
            ),
    );
  }
}
