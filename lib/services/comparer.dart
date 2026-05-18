import 'package:mycookbook_gemini/domain/models/parsed_recipe.dart';
import 'package:mycookbook_gemini/domain/models/fixture.dart';
import 'package:mycookbook_gemini/domain/models/evaluation_report.dart';
import 'package:mycookbook_gemini/services/normalizer.dart';

class Comparer {
  final StringNormalizer _normalizer = StringNormalizer();

  double matchIngredients(List<IngredientExpectation> expected, List<Ingredient> actual) {
    int matchedCount = 0;
    final List<Ingredient> remainingActual = List.from(actual);

    for (var exp in expected) {
      final normalizedExpName = _normalizer.normalize(exp.name);

      for (int i = 0; i < remainingActual.length; i++) {
        if (remainingActual[i].name == normalizedExpName) {
          matchedCount++;
          remainingActual.removeAt(i);
          break;
        }
      }
    }

    if (expected.isEmpty && actual.isEmpty) return 1.0;
    return (2 * matchedCount) / (expected.length + actual.length);
  }

  double matchSteps(List<String> expected, List<Step> actual) {
    if (expected.isEmpty) return actual.isEmpty ? 1.0 : 0.0;

    int matchedInOrder = 0;
    for (int i = 0; i < expected.length && i < actual.length; i++) {
      if (_normalizer.normalize(expected[i]) == actual[i].description) {
        matchedInOrder++;
      }
    }
    return matchedInOrder / expected.length;
  }

  double detectNoise(String text, List<String> forbidden) {
    final lines = text.split('\n');
    final patterns = [
      RegExp(r'https?://\S+'),
      RegExp(r'(подпис|telegram|instagram|промокод|реклам)', caseSensitive: false),
    ];
    
    int leakCount = 0;
    for (var line in lines) {
      for (var p in patterns) if (p.hasMatch(line)) leakCount++;
      for (var f in forbidden) if (line.contains(f)) leakCount++;
    }
    
    return lines.isEmpty ? 1.0 : (1.0 - (leakCount / lines.length)).clamp(0.0, 1.0);
  }

  IngredientDiff calculateIngredientDiff(List<IngredientExpectation> expected, List<Ingredient> actual) {
    final falsePositives = <FailureRecord>[];
    final falseNegatives = <FailureRecord>[];

    final actualNormalized = actual.map((i) => i.name).toSet();
    final expectedNormalized = expected.map((e) => _normalizer.normalize(e.name)).toSet();

    for (var act in actual) {
      if (!expectedNormalized.contains(act.name)) {
        falsePositives.add(FailureRecord(type: 'ingredient', actual: act.name));
      }
    }
    for (var exp in expected) {
      if (!actualNormalized.contains(_normalizer.normalize(exp.name))) {
        falseNegatives.add(FailureRecord(type: 'ingredient', expected: exp.name));
      }
    }

    return IngredientDiff(falsePositives, falseNegatives);
  }
}

class IngredientDiff {
  final List<FailureRecord> falsePositives;
  final List<FailureRecord> falseNegatives;
  IngredientDiff(this.falsePositives, this.falseNegatives);
}
