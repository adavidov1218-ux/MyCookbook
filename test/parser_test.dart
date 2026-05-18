import 'package:flutter_test/flutter_test.dart';
import 'package:mycookbook_gemini/services/recipe_parser.dart';

void main() {
  final parser = RecipeParser();

  test('Complex parsing including all edge cases', () {
    const input = '''
      Блины на молоке
      Ингредиенты:
      200 г муки
      2 яйца
      1,5 стакана молока
      Приготовление:
      1. Смешайте ингредиенты.
      2. Нарежьте овощи.
      3. Обжарьте до золотистости.
      4. Подавайте горячими.
      Подпишись на канал: http://youtube.com
      Реклама: промокод "GARIK"
    ''';

    final r = parser.parse(text: input, fallbackTitle: 'Блины на молоке');
    expect(r.title, 'Блины на молоке');
    expect(r.ingredients.length, 3);
    expect(r.steps.length, 4);
  });

  test('Edge cases parsing', () {
    final r1 = parser.parse(text: 'Ингредиенты:\n2 яйца', fallbackTitle: 'Test');
    expect(r1.ingredients.isNotEmpty, isTrue);

    final r2 = parser.parse(text: 'Ингредиенты:\n200 г муки', fallbackTitle: 'Test');
    expect(r2.ingredients.isNotEmpty, isTrue);
  });

  test('Junk filtering', () {
    const input = 'Состав:\nРеклама: купите у нас\n200 г муки\nСотрудничество: email@mail.com';
    final r = parser.parse(text: input, fallbackTitle: 'Test');
    expect(r.ingredients.length, 1);
  });
}
