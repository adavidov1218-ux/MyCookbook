import 'package:mycookbook_gemini/services/recipe_parser.dart';
import 'golden_recipe_dataset.dart';

void main() {
  final parser = RecipeParser();
  print('--- AUDIT REPORT ---');
  
  for (final gc in goldenDataset) {
    final res = parser.parse(text: gc.input, fallbackTitle: gc.name);
    print('\nCase: ${gc.name}');
    print('Input: ${gc.input.replaceAll('\n', ' | ')}');
    print('Ingredients: ${res.ingredients}');
    print('Steps: ${res.steps.map((s) => s.description)}');
    print('Quality: ${res.diagnostics.quality}');
    print('Fallback: ${res.diagnostics.usedFallback}');
  }
}
