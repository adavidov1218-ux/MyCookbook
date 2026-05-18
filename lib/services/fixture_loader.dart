import 'dart:convert';
import 'dart:io';
import 'package:mycookbook_gemini/domain/models/fixture.dart';

class FixtureLoader {
  List<Fixture> loadAllFromDirectory(String path) {
    final dir = Directory(path);
    final List<Fixture> fixtures = [];
    
    if (!dir.existsSync()) return fixtures;

    for (var file in dir.listSync(recursive: true)) {
      if (file is File && file.path.endsWith('.json')) {
        final content = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        fixtures.add(_fromJson(content));
      }
    }
    return fixtures;
  }

  Fixture _fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'] as String,
      schemaVersion: json['schema_version'] as String,
      tags: FixtureTags(
        structural: List<String>.from(json['tags']['structural']),
        semantic: List<String>.from(json['tags']['semantic']),
        quality: List<String>.from(json['tags']['quality']),
      ),
      input: FixtureInput(
        sourceType: json['input']['source_type'] as String,
        rawText: json['input']['raw_text'] as String,
      ),
      expectedIngredients: (json['expectations']['ingredients'] as List)
          .map((i) => IngredientExpectation(
                name: i['name'] as String,
                qty: i['qty'] as String?,
                unit: i['unit'] as String?,
              ))
          .toList(),
      expectedSteps: List<String>.from(json['expectations']['steps']),
      forbiddenPatterns: List<String>.from(json['expectations']['forbidden_patterns']),
      fuzzyThreshold: (json['tolerances']['fuzzy_threshold'] as num).toDouble(),
    );
  }
}
