import 'package:flutter_test/flutter_test.dart';
import 'package:mycookbook_gemini/services/recipe_parser.dart';
import 'golden_behavior_dataset.dart';

void main() {
  final parser = RecipeParser();

  group('RecipeParser - Golden Behavior Tests (DESIRED)', () {
    int passed = 0;
    int failed = 0;
    final failedCases = <String>[];

    for (final goldenCase in goldenBehaviorDataset) {
      test('Golden: ${goldenCase.name}', () {
        final result = parser.parse(text: goldenCase.input, fallbackTitle: 'test');

        final actualIngredients = result.ingredients.map((e) => e.name.trim()).toList();
        final actualSteps = result.steps.map((e) => e.description.trim()).toList();

        try {
          expect(actualIngredients, containsAll(goldenCase.expectedIngredients.map((e) => e.trim())),
              reason: 'Ingredients mismatch');
          expect(actualSteps, containsAll(goldenCase.expectedSteps.map((e) => e.trim())),
              reason: 'Steps mismatch');

          expect(result.diagnostics.quality.index >= goldenCase.minQuality.index, true,
              reason: 'Quality too low');
          passed++;
        } catch (e) {
          failed++;
          failedCases.add(goldenCase.name);
          print('FAILED: ${goldenCase.name}');
          print('  Expected ingredients: ${goldenCase.expectedIngredients}');
          print('  Actual ingredients: $actualIngredients');
          print('  Expected steps: ${goldenCase.expectedSteps}');
          print('  Actual steps: $actualSteps');
          rethrow;
        }
      });
    }

    test('Golden Behavior Summary', () {
      print('\n--- GOLDEN BEHAVIOR TEST SUMMARY ---');
      print('Passed: $passed');
      print('Failed: $failed');
      if (failedCases.isNotEmpty) {
        print('Failed cases:');
        for (final name in failedCases) {
          print('  - $name');
        }
      }
      print('------------------------------------');
      expect(failed, 0, reason: 'Some golden behavior tests failed - parser needs improvements');
    });
  });
}
