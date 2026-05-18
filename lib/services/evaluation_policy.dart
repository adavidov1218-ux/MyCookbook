import 'package:mycookbook_gemini/domain/models/fixture.dart';
import 'package:mycookbook_gemini/domain/models/evaluation_report.dart';

class EvaluationPolicy {
  bool isPass(Fixture fixture, EvaluationMetrics metrics) {
    // В будущем можно расширить логику с учетом fixture.tolerances
    return metrics.ingredientF1 >= 0.8 && 
           metrics.stepOrderScore >= 0.9 && 
           metrics.noiseLeakScore >= 0.9;
  }
}
