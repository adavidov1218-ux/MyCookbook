import 'package:equatable/equatable.dart';

class ComparisonResult extends Equatable {
  final double ingredientF1;
  final double stepOrderScore;
  final double noiseLeakScore;
  final List<Map<String, String>> falsePositives;
  final List<Map<String, String>> falseNegatives;

  const ComparisonResult({
    required this.ingredientF1,
    required this.stepOrderScore,
    required this.noiseLeakScore,
    required this.falsePositives,
    required this.falseNegatives,
  });

  @override
  List<Object?> get props => [ingredientF1, stepOrderScore, noiseLeakScore, falsePositives, falseNegatives];
}
