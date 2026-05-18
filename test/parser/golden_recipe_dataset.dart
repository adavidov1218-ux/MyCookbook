import 'package:mycookbook_gemini/services/recipe_parser.dart';
import 'package:mycookbook_gemini/domain/models/parsed_recipe.dart';

class GoldenCase {
  final String name;
  final String input;
  final List<String> expectedIngredients;
  final List<String> expectedSteps;
  final ParseQuality minQuality;

  GoldenCase({
    required this.name,
    required this.input,
    required this.expectedIngredients,
    required this.expectedSteps,
    required this.minQuality,
  });
}

final List<GoldenCase> goldenDataset = [
  GoldenCase(name: 'Standard recipe', input: 'Ингредиенты:\n500 г муки\n200 мл молока\nПриготовление:\n1. Смешать\n2. Выпекать', expectedIngredients: ['муки', 'молока'], expectedSteps: ['смешать', 'выпекать'], minQuality: ParseQuality.high),
  GoldenCase(name: 'No-qty ingredients', input: 'соль по вкусу\nперец\nзелень\n1. Нарезать', expectedIngredients: [], expectedSteps: ['нарезать'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Caps noise', input: 'ПРИЯТНОГО АППЕТИТА\n1. Смешать яйца', expectedIngredients: [], expectedSteps: ['смешать яйца'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Junk text', input: 'Подписывайтесь!!! http://youtube.com\n1. Жарить', expectedIngredients: [], expectedSteps: ['жарить'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Timestamp heavy', input: '01:20 Смешать\n02:30 Жарить', expectedIngredients: [], expectedSteps: [], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Bullets', input: '• мука 500 г\n• сахар 200 г\n1. Взбить', expectedIngredients: ['мука 500 г', 'сахар 200 г'], expectedSteps: ['взбить'], minQuality: ParseQuality.high),
  GoldenCase(name: 'Mixed format', input: 'Состав: мука 500 г\nСмешать яйца\n2. Добавить молоко', expectedIngredients: ['состав: мука 500 г'], expectedSteps: ['добавить молоко'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Short recipe', input: 'Яйца 2 шт\nСмешать', expectedIngredients: ['яйца 2 шт'], expectedSteps: [], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Multiline merge', input: '1. Смешать яйца\nи сахар\nдо пены', expectedIngredients: [], expectedSteps: ['смешать яйца'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Empty description', input: '', expectedIngredients: [], expectedSteps: [], minQuality: ParseQuality.low),
  GoldenCase(name: 'Only ingredients', input: 'мука 500 г\nмолоко 1 л', expectedIngredients: ['мука 500 г', 'молоко 1 л'], expectedSteps: [], minQuality: ParseQuality.medium),
  GoldenCase(name: 'No steps header', input: '500 г муки\nВзбить яйца\nДобавить муку', expectedIngredients: ['муки'], expectedSteps: [], minQuality: ParseQuality.medium),
  GoldenCase(name: 'No ingredients header', input: 'Яйца 3 шт\n1. Взбить', expectedIngredients: ['яйца 3 шт'], expectedSteps: ['взбить'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Promo heavy', input: 'Купите скидку! Промокод ААА\n1. Жарить', expectedIngredients: [], expectedSteps: ['жарить'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Shorts noise', input: 'https://youtube.com/shorts/123\n1. Смешать', expectedIngredients: [], expectedSteps: ['смешать'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Very short', input: '1. Есть', expectedIngredients: [], expectedSteps: ['есть'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Caps and junk', input: 'ПОДПИШИСЬ\nМУКА 500 Г\n1. СМЕШАТЬ', expectedIngredients: ['мука 500 г'], expectedSteps: ['смешать'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Newline noise', input: '\n\n\n1. Нарезать\n\n', expectedIngredients: [], expectedSteps: ['нарезать'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Unicode dash', input: 'мука – 500 г\n1. Взбить', expectedIngredients: ['мука - 500 г'], expectedSteps: ['взбить'], minQuality: ParseQuality.medium),
  GoldenCase(name: 'Complex recipe', input: 'ИНГРЕДИЕНТЫ:\nмука 500 г\nсоль\nПРИГОТОВЛЕНИЕ:\n1. Смешать муку с солью\n2. Выпекать', expectedIngredients: ['мука 500 г'], expectedSteps: ['смешать муку с солью', 'выпекать'], minQuality: ParseQuality.high),
];
