import 'package:flutter_test/flutter_test.dart';
import 'package:mycookbook_gemini/services/recipe_parser.dart';
import 'golden_behavior_dataset.dart';

void main() {
  final parser = RecipeParser();

  group('RecipeParser Regression Tests', () {
    int passed = 0;
    int failed = 0;

    for (final goldenCase in goldenBehaviorDataset) {
      test('Golden Case: ${goldenCase.name}', () {
        final result = parser.parse(text: goldenCase.input, fallbackTitle: 'test');

        final actualIngredients = result.ingredients.map((e) => e.name.trim()).toList();
        final actualSteps = result.steps.map((e) => e.description.trim()).toList();

        try {
          expect(actualIngredients, containsAll(goldenCase.expectedIngredients.map((e) => e.trim())));
          expect(actualSteps, containsAll(goldenCase.expectedSteps.map((e) => e.trim())));

          expect(result.diagnostics.quality.index >= goldenCase.minQuality.index, true, reason: 'Quality too low');
          passed++;
        } catch (e) {
          failed++;
          print('FAILED: ${goldenCase.name}\nActual Ingredients: $actualIngredients\nActual Steps: $actualSteps');
          rethrow;
        }
      });
    }

    test('Regression Summary', () {
      print('--- TEST SUMMARY ---');
      print('Passed: $passed');
      print('Failed: $failed');
      print('--------------------');
      expect(failed, 0, reason: 'Some regression tests failed');
    });
  });
}

