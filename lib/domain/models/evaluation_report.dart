import 'package:equatable/equatable.dart';

class FailureRecord extends Equatable {
  final String type;
  final String? expected;
  final String? actual;

  const FailureRecord({required this.type, this.expected, this.actual});

  @override
  List<Object?> get props => [type, expected, actual];
}

class EvaluationMetrics extends Equatable {
  final double ingredientF1;
  final double stepOrderScore;
  final double noiseLeakScore;
  final int processingTimeMs;

  const EvaluationMetrics({
    required this.ingredientF1,
    required this.stepOrderScore,
    required this.noiseLeakScore,
    required this.processingTimeMs,
  });

  @override
  List<Object?> get props => [ingredientF1, stepOrderScore, noiseLeakScore, processingTimeMs];
}

class EvaluationReport extends Equatable {
  final String fixtureId;
  final String status;
  final EvaluationMetrics metrics;
  final List<FailureRecord> falsePositives;
  final List<FailureRecord> falseNegatives;
  final List<String> normalizationMismatches;
  final String diagnosticsStage;
  final String diagnosticsReason;

  const EvaluationReport({
    required this.fixtureId,
    required this.status,
    required this.metrics,
    required this.falsePositives,
    required this.falseNegatives,
    required this.normalizationMismatches,
    required this.diagnosticsStage,
    required this.diagnosticsReason,
  });

  @override
  List<Object?> get props => [fixtureId, status, metrics, falsePositives, falseNegatives, normalizationMismatches, diagnosticsStage, diagnosticsReason];
}
