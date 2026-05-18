import 'package:mycookbook_gemini/services/recipe_parser.dart';
import 'golden_recipe_dataset.dart';

void main() {
  final parser = RecipeParser();

  print('=== REGRESSION FORENSIC ANALYSIS ===\n');

  final failingTests = [
    'Standard recipe',
    'No-qty ingredients',
    'Timestamp heavy',
    'Bullets',
    'Mixed format',
    'Short recipe',
    'Multiline merge',
    'No steps header',
    'Unicode dash',
    'Complex recipe',
  ];

  for (var testName in failingTests) {
    final testCase = goldenDataset.firstWhere((t) => t.name == testName);

    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('TEST: ${testCase.name}');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

    print('INPUT:\n${testCase.input}\n');

    final result = parser.parse(text: testCase.input, fallbackTitle: 'Test');

    print('EXPECTED INGREDIENTS: ${testCase.expectedIngredients}');
    print('ACTUAL INGREDIENTS:   ${result.ingredients.map((i) => i.toString()).toList()}');
    print('MATCH: ${_compareIngredients(testCase.expectedIngredients, result.ingredients)}\n');

    print('EXPECTED STEPS: ${testCase.expectedSteps}');
    print('ACTUAL STEPS:   ${result.steps.map((s) => s.description).toList()}');
    print('MATCH: ${_compareSteps(testCase.expectedSteps, result.steps)}\n');

    // Analyze root cause
    _analyzeFailure(testCase, result);

    print('\n');
  }
}

bool _compareIngredients(List<String> expected, List<dynamic> actual) {
  final actualStrs = actual.map((i) => i.toString()).toList();
  return expected.every((e) => actualStrs.any((a) => a.contains(e) || e.contains(a)));
}

bool _compareSteps(List<String> expected, List<dynamic> actual) {
  final actualStrs = actual.map((s) => s.description).toList();
  return expected.every((e) => actualStrs.any((a) => a.contains(e) || e.contains(a)));
}

void _analyzeFailure(GoldenCase testCase, dynamic result) {
  final actualIngredients = result.ingredients.map((i) => i.toString()).toList();
  final actualSteps = result.steps.map((s) => s.description).toList();

  print('ROOT CAUSE ANALYSIS:');

  // Ingredient analysis
  if (testCase.expectedIngredients.isNotEmpty && actualIngredients.isEmpty) {
    print('  ❌ INGREDIENTS: All ingredients lost');
    print('     Reason: _isIngredient() returns false for all lines');
  } else if (testCase.expectedIngredients.isNotEmpty && actualIngredients.isNotEmpty) {
    final missing = testCase.expectedIngredients
        .where((e) => !actualIngredients.any((a) => a.contains(e) || e.contains(a)))
        .toList();
    if (missing.isNotEmpty) {
      print('  ⚠️ INGREDIENTS: Missing ${missing.length}');
      for (var m in missing) {
        print('     - "$m"');
      }
    }
    final extra = actualIngredients
        .where((a) => !testCase.expectedIngredients.any((e) => a.contains(e) || e.contains(a)))
        .toList();
    if (extra.isNotEmpty) {
      print('  ⚠️ INGREDIENTS: Extra ${extra.length}');
      for (var e in extra) {
        print('     - "$e"');
      }
    }
  }

  // Step analysis
  if (testCase.expectedSteps.isNotEmpty && actualSteps.isEmpty) {
    print('  ❌ STEPS: All steps lost');
    print('     Reason: _isStep() returns false or steps merged incorrectly');
  } else if (testCase.expectedSteps.isNotEmpty && actualSteps.isNotEmpty) {
    final missing = testCase.expectedSteps
        .where((e) => !actualSteps.any((a) => a.contains(e) || e.contains(a)))
        .toList();
    if (missing.isNotEmpty) {
      print('  ⚠️ STEPS: Missing ${missing.length}');
      for (var m in missing) {
        print('     - "$m"');
      }
    }
  }
}
