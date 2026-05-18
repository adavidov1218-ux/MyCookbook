import 'package:flutter_test/flutter_test.dart';
import 'package:mycookbook_gemini/services/recipe_parser.dart';

void main() {
  final parser = RecipeParser();

  group('RecipeParser - Header Regex Tests', () {
    // Test using the actual parser's regex behavior through parsing
    test('Header "Ингредиенты" is skipped during parsing', () {
      final input = '''Ингредиенты
2 яйца
100 г муки''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');
      // Header should be skipped, so we should get ingredients, not a noise block
      expect(result.ingredients.isNotEmpty, isTrue);
    });

    test('Header "Ингредиенты:" is skipped during parsing', () {
      final input = '''Ингредиенты:
2 яйца
100 г муки''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');
      expect(result.ingredients.isNotEmpty, isTrue);
    });

    test('Header "Состав" is skipped during parsing', () {
      final input = '''Состав
400 г спагетти
200 г бекона''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');
      expect(result.ingredients.isNotEmpty, isTrue);
    });

    test('Header "Приготовление:" is skipped during parsing', () {
      final input = '''Приготовление:
1. Смешать
2. Выпечь''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');
      expect(result.steps.length, equals(2));
    });

    test('Step with "ингредиенты" in text is NOT skipped', () {
      final input = '''3. Соединить сухие и влажные ингредиенты
4. Дать тесту постоять''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');
      expect(result.steps.length, equals(2),
          reason: 'Should extract both steps, not skip the one with "ингредиенты"');
    });

    test('Step "Добавить ингредиенты в миску" is NOT skipped', () {
      final input = '''1. Смешать яйца
2. Добавить ингредиенты в миску
3. Выпечь''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');
      expect(result.steps.length, equals(3),
          reason: 'Should extract all 3 steps');
    });

    test('Step "Шаг 2. Смешать ингредиенты" is NOT skipped', () {
      final input = '''1. Смешать яйца
Шаг 2. Смешать ингредиенты
3. Выпечь''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');
      // "Шаг 2. Смешать ингредиенты" should be recognized as a step
      expect(result.steps.length, greaterThanOrEqualTo(2));
    });
  });

  group('RecipeParser - Pancakes Regression Test', () {
    test('Pancakes recipe extracts all 8 steps correctly', () {
      final pancakesInput = '''Блины пышные
Ингредиенты:
1 стакан молока
1 стакан муки
2 яйца
1 ст.л. сахара
1 ч.л. соли
1 ч.л. разрыхлителя
масло для жарки

Рецепт:
1. Смешать муку, сахар, соль и разрыхлитель в миске
2. В отдельной миске взбить яйца с молоком
3. Соединить сухие и влажные ингредиенты, перемешать до однородности
4. Дать тесту постоять 5 минут
5. Разогреть масло на сковороде
6. Выливать тесто порциями и жарить с обеих сторон до золотистости
7. Выложить на тарелку
8. Подавать горячими с вареньем или сметаной''';

      final result = parser.parse(text: pancakesInput, fallbackTitle: 'Блины');

      expect(result.steps.length, equals(8), reason: 'Should extract 8 steps');
    });

    test('Pancakes recipe step 3 contains "соединить сухие и влажные"', () {
      final pancakesInput = '''Блины пышные
Ингредиенты:
1 стакан молока
1 стакан муки
2 яйца
1 ст.л. сахара
1 ч.л. соли
1 ч.л. разрыхлителя
масло для жарки

Рецепт:
1. Смешать муку, сахар, соль и разрыхлитель в миске
2. В отдельной миске взбить яйца с молоком
3. Соединить сухие и влажные ингредиенты, перемешать до однородности
4. Дать тесту постоять 5 минут
5. Разогреть масло на сковороде
6. Выливать тесто порциями и жарить с обеих сторон до золотистости
7. Выложить на тарелку
8. Подавать горячими с вареньем или сметаной''';

      final result = parser.parse(text: pancakesInput, fallbackTitle: 'Блины');

      expect(result.steps.length, greaterThanOrEqualTo(3),
          reason: 'Should have at least 3 steps');
      expect(
        result.steps[2].description,
        contains('соединить сухие и влажные'),
        reason: 'Step 3 should contain "соединить сухие и влажные"',
      );
    });

    test('Pancakes recipe step 3 exact text', () {
      final pancakesInput = '''Блины пышные
Ингредиенты:
1 стакан молока
1 стакан муки
2 яйца
1 ст.л. сахара
1 ч.л. соли
1 ч.л. разрыхлителя
масло для жарки

Рецепт:
1. Смешать муку, сахар, соль и разрыхлитель в миске
2. В отдельной миске взбить яйца с молоком
3. Соединить сухие и влажные ингредиенты, перемешать до однородности
4. Дать тесту постоять 5 минут
5. Разогреть масло на сковороде
6. Выливать тесто порциями и жарить с обеих сторон до золотистости
7. Выложить на тарелку
8. Подавать горячими с вареньем или сметаной''';

      final result = parser.parse(text: pancakesInput, fallbackTitle: 'Блины');

      expect(
        result.steps[2].description,
        equals('соединить сухие и влажные ингредиенты, перемешать до однородности'),
        reason: 'Step 3 should have exact text',
      );
    });
  });

  group('RecipeParser - Unicode Dash Normalization', () {
    test('Unicode dash is normalized to ASCII dash in ingredients', () {
      final input = 'мука – 500 г\n1. Взбить';
      final result = parser.parse(text: input, fallbackTitle: 'Test');

      expect(result.ingredients.isNotEmpty, isTrue);
      expect(result.ingredients[0].toString(), contains('мука'));
      expect(result.ingredients[0].toString(), contains('500'));
    });

    test('Em dash is normalized to ASCII dash in ingredients', () {
      final input = 'мука — 500 г\n1. Взбить';
      final result = parser.parse(text: input, fallbackTitle: 'Test');

      expect(result.ingredients.isNotEmpty, isTrue);
      expect(result.ingredients[0].toString(), contains('мука'));
    });
  });

  group('RecipeParser - Bullet Symbol Cleanup', () {
    test('Bullet symbols are removed from ingredients', () {
      final input = '• мука 500 г\n• сахар 200 г\n1. Взбить';
      final result = parser.parse(text: input, fallbackTitle: 'Test');

      expect(result.ingredients.length, equals(2));
      expect(result.ingredients[0].toString(), contains('мука'));
      expect(result.ingredients[1].toString(), contains('сахар'));
      expect(result.ingredients[0].toString(), isNot(contains('•')));
      expect(result.ingredients[1].toString(), isNot(contains('•')));
    });

    test('Various bullet symbols are removed', () {
      final input = '● мука 500 г\n▪ сахар 200 г\n◦ масло 100 г\n1. Взбить';
      final result = parser.parse(text: input, fallbackTitle: 'Test');

      expect(result.ingredients.length, equals(3));
      for (var ing in result.ingredients) {
        expect(ing.toString(), isNot(contains('●')));
        expect(ing.toString(), isNot(contains('▪')));
        expect(ing.toString(), isNot(contains('◦')));
      }
    });
  });

  group('RecipeParser - Segmentation Tests', () {
    test('Parser correctly segments ingredients and steps', () {
      final input = '''Ингредиенты:
2 яйца
100 г муки

Приготовление:
1. Смешать яйца и муку
2. Выпечь''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');

      expect(result.ingredients.isNotEmpty, isTrue,
          reason: 'Should extract ingredients');
      expect(result.steps.length, equals(2), reason: 'Should extract 2 steps');
    });

    test('Parser does not lose steps with "ингредиенты" in text', () {
      final input = '''1. Смешать все ингредиенты
2. Выпечь''';

      final result = parser.parse(text: input, fallbackTitle: 'Test');

      expect(result.steps.length, equals(2),
          reason: 'Should not lose step with "ингредиенты" in text');
      expect(result.steps[0].description, contains('смешать все ингредиенты'));
    });
  });
}

