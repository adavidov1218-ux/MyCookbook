import 'dart:io';
import 'package:mycookbook_gemini/services/fixture_loader.dart';
import 'package:mycookbook_gemini/services/recipe_ingestion_orchestrator.dart';
import 'package:mycookbook_gemini/services/recipe_parser.dart';

void main(List<String> args) {
  final loader = FixtureLoader();
  final orchestrator = RecipeIngestionOrchestrator();
  final parser = RecipeParser();
  
  final fixtures = loader.loadAllFromDirectory('test/parser/fixtures');
  int total = fixtures.length;
  int passed = 0;

  if (total == 0) {
    print('Error: No fixtures found in test/parser/fixtures');
    exit(1);
  }

  for (var fixture in fixtures) {
    final parsed = parser.parse(text: fixture.input.rawText, fallbackTitle: "Test");
    final report = orchestrator.evaluate(fixture, parsed);
    
    if (report.status == 'PASS') {
      passed++;
    } else {
      print('FAIL: ${fixture.id} - ${report.diagnosticsReason}');
      print('Metrics: ${report.metrics}');
      print('Parsed ingredients: ${parsed.ingredients}');
      print('Parsed steps: ${parsed.steps}');
    }
  }

  print('\nTOTAL: $total');
  print('PASS: $passed');
  print('FAIL: ${total - passed}');
  print('SUCCESS RATE: ${(passed / total * 100).toStringAsFixed(1)}%');

  exit(total - passed > 0 ? 1 : 0);
}
