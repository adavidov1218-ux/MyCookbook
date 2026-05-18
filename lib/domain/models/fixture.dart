import 'package:equatable/equatable.dart';

class FixtureTags extends Equatable {
  final List<String> structural;
  final List<String> semantic;
  final List<String> quality;

  const FixtureTags({required this.structural, required this.semantic, required this.quality});

  @override
  List<Object?> get props => [structural, semantic, quality];
}

class FixtureInput extends Equatable {
  final String sourceType;
  final String rawText;

  const FixtureInput({required this.sourceType, required this.rawText});

  @override
  List<Object?> get props => [sourceType, rawText];
}

class IngredientExpectation extends Equatable {
  final String name;
  final String? qty;
  final String? unit;

  const IngredientExpectation({required this.name, this.qty, this.unit});

  @override
  List<Object?> get props => [name, qty, unit];
}

class Fixture extends Equatable {
  final String id;
  final String schemaVersion;
  final FixtureTags tags;
  final FixtureInput input;
  final List<IngredientExpectation> expectedIngredients;
  final List<String> expectedSteps;
  final List<String> forbiddenPatterns;
  final double fuzzyThreshold;

  const Fixture({
    required this.id,
    required this.schemaVersion,
    required this.tags,
    required this.input,
    required this.expectedIngredients,
    required this.expectedSteps,
    required this.forbiddenPatterns,
    this.fuzzyThreshold = 0.85,
  });

  @override
  List<Object?> get props => [id, schemaVersion, tags, input, expectedIngredients, expectedSteps, forbiddenPatterns, fuzzyThreshold];
}
