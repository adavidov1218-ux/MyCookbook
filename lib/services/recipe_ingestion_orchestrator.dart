import 'package:mycookbook_gemini/domain/models/fixture.dart';
import 'package:mycookbook_gemini/domain/models/parsed_recipe.dart';
import 'package:mycookbook_gemini/domain/models/evaluation_report.dart';
import 'package:mycookbook_gemini/services/comparer.dart';
import 'package:mycookbook_gemini/services/evaluation_policy.dart';
import 'package:mycookbook_gemini/services/normalizer.dart';
import 'package:mycookbook_gemini/services/recipe_parser.dart';
import 'package:mycookbook_gemini/services/preprocessing_pipeline.dart';

class RecipeIngestionOrchestrator {
  final Comparer _comparer = Comparer();
  final EvaluationPolicy _policy = EvaluationPolicy();
  final StringNormalizer _normalizer = StringNormalizer();
  final RecipeParser _parser = RecipeParser();
  final YouTubePreprocessingPipeline _pipeline = YouTubePreprocessingPipeline();

  ParsedRecipe orchestrate({
    required String rawText,
    required String fallbackTitle,
  }) {
    final preprocessed = _pipeline.process(rawText);
    return _parser.parse(
      text: preprocessed.cleanedRecipeText,
      fallbackTitle: fallbackTitle,
    );
  }

  EvaluationReport evaluate(Fixture fixture, ParsedRecipe actual) {
    final sw = Stopwatch()..start();

    final ingredientF1 = _comparer.matchIngredients(
      fixture.expectedIngredients,
      actual.ingredients,
    );

    final stepOrderScore = _comparer.matchSteps(
      fixture.expectedSteps,
      actual.steps,
    );

    final noiseLeakScore = _comparer.detectNoise(
      actual.rawText,
      fixture.forbiddenPatterns,
    );

    // Delegate calculation of false positives/negatives to the Comparer, 
    // as it already holds matching and normalization knowledge.
    final ingredientDiff = _comparer.calculateIngredientDiff(
      fixture.expectedIngredients,
      actual.ingredients,
    );

    final metrics = EvaluationMetrics(
      ingredientF1: ingredientF1,
      stepOrderScore: stepOrderScore,
      noiseLeakScore: noiseLeakScore,
      processingTimeMs: sw.elapsedMilliseconds,
    );

    final isPass = _policy.isPass(fixture, metrics);

    return EvaluationReport(
      fixtureId: fixture.id,
      status: isPass ? 'PASS' : 'FAIL',
      metrics: metrics,
      falsePositives: ingredientDiff.falsePositives,
      falseNegatives: ingredientDiff.falseNegatives,
      normalizationMismatches: [],
      diagnosticsStage: 'orchestrator',
      diagnosticsReason: isPass ? 'OK' : 'Quality threshold violation',
    );
  }
}
