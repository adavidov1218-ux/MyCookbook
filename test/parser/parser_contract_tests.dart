import 'package:flutter_test/flutter_test.dart';
import 'package:mycookbook_gemini/services/recipe_parser.dart';

void main() {
  final parser = RecipeParser();

  group('STABLE CONTRACT v1: Parser Invariants', () {
    
    test('Rule 1: Junk removal (Non-deterministic junk must be gone)', () {
      final res = parser.parse(text: 'http://youtube.com/watch\nподписывайтесь', fallbackTitle: 't');
      expect(res.ingredients.isEmpty, isTrue);
      expect(res.steps.isEmpty, isTrue);
    });

    test('Rule 2: Section override (Keywords have absolute priority)', () {
      final res = parser.parse(text: 'Ингредиенты:\n1. Смешать\nПриготовление:\n2. Выпекать', fallbackTitle: 't');
      // "Ингредиенты" и "Приготовление" должны быть удалены и не попасть в список
      expect(res.ingredients.any((i) => i.name.contains('Ингредиенты')), isFalse);
      expect(res.steps.any((s) => s.description.contains('Приготовление')), isFalse);
    });

    test('Rule 3: Step-First Aggregation (No ingredients in steps)', () {
      final res = parser.parse(text: '1. Смешать яйца\n2. Выпекать', fallbackTitle: 't');
      expect(res.steps.length, equals(2));
      expect(res.ingredients.length, equals(0));
    });

    test('Rule 5: Continuation only in steps', () {
      // "и добавить молоко" приклеивается к шагу, если это не маркер
      final res = parser.parse(text: '1. Смешать яйца\nи добавить молоко', fallbackTitle: 't');
      expect(res.steps.length, equals(1));
      expect(res.steps.first.description.contains('и добавить молоко'), isTrue);
    });

    test('Rule 6: Raw Fallback preservation', () {
      final text = 'some random text';
      final res = parser.parse(text: text, fallbackTitle: 't');
      expect(res.rawText, equals(text));
    });

    test('Rule 7: Quality threshold high (min 3 ing, 2 steps)', () {
      final res = parser.parse(text: '500 г муки\n200 мл молока\n100 г масла\n1. Смешать\n2. Выпекать', fallbackTitle: 't');
      expect(res.diagnostics.quality, equals(ParseQuality.high));
    });

    test('Rule 8: Timestamp preservation (1:2)', () {
      final res = parser.parse(text: 'Смешать в пропорции 1:2', fallbackTitle: 't');
      expect(res.rawText.contains('1:2'), isTrue);
    });
  });
}
