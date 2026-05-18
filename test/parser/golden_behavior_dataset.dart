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

final List<GoldenCase> goldenBehaviorDataset = [
  // DESIRED BEHAVIOR: Ingredients with explicit quantity
  GoldenCase(
    name: 'Standard recipe with quantities',
    input: 'Ингредиенты:\n500 г муки\n200 мл молока\nПриготовление:\n1. Смешать\n2. Выпекать',
    expectedIngredients: ['муки', 'молока'],
    expectedSteps: ['смешать', 'выпекать'],
    minQuality: ParseQuality.high,
  ),

  // DESIRED BEHAVIOR: Ingredients WITHOUT quantity (semantic detection)
  GoldenCase(
    name: 'Ingredients without quantity',
    input: 'соль по вкусу\nперец\nзелень\n1. Нарезать',
    expectedIngredients: ['соль по вкусу', 'перец', 'зелень'],
    expectedSteps: ['нарезать'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: Implicit steps (no explicit markers)
  GoldenCase(
    name: 'Implicit steps without markers',
    input: 'Смешать яйца\nДобавить молоко\nВыпекать 20 минут',
    expectedIngredients: [],
    expectedSteps: ['смешать яйца', 'добавить молоко', 'выпекать 20 минут'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: Timestamp-prefixed steps
  GoldenCase(
    name: 'Timestamp-prefixed steps',
    input: '01:20 Смешать\n02:30 Жарить',
    expectedIngredients: [],
    expectedSteps: ['смешать', 'жарить'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: Multiline continuation merge
  GoldenCase(
    name: 'Multiline step continuation',
    input: '1. Смешать яйца\nи сахар\nдо пены',
    expectedIngredients: [],
    expectedSteps: ['смешать яйца и сахар до пены'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: Inline header stripping
  GoldenCase(
    name: 'Inline header stripping',
    input: 'Состав: мука 500 г\nСмешать яйца\n2. Добавить молоко',
    expectedIngredients: ['мука 500 г'],
    expectedSteps: ['смешать яйца', 'добавить молоко'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: Mixed explicit and implicit steps
  GoldenCase(
    name: 'Mixed explicit and implicit steps',
    input: 'Яйца 3 шт\n1. Взбить\nДобавить сахар',
    expectedIngredients: ['яйца 3 шт'],
    expectedSteps: ['взбить', 'добавить сахар'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: No-qty ingredients with explicit steps
  GoldenCase(
    name: 'No-qty ingredients with steps',
    input: '500 г муки\nВзбить яйца\nДобавить муку',
    expectedIngredients: ['муки'],
    expectedSteps: ['взбить яйца', 'добавить муку'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: Complex recipe with all features
  GoldenCase(
    name: 'Complex recipe with all features',
    input: 'ИНГРЕДИЕНТЫ:\nмука 500 г\nсоль\nПРИГОТОВЛЕНИЕ:\n1. Смешать муку с солью\n2. Выпекать',
    expectedIngredients: ['мука 500 г', 'соль'],
    expectedSteps: ['смешать муку с солью', 'выпекать'],
    minQuality: ParseQuality.high,
  ),

  // DESIRED BEHAVIOR: Bullets cleanup
  GoldenCase(
    name: 'Bullet symbols cleanup',
    input: '• мука 500 г\n• сахар 200 г\n1. Взбить',
    expectedIngredients: ['мука 500 г', 'сахар 200 г'],
    expectedSteps: ['взбить'],
    minQuality: ParseQuality.high,
  ),

  // DESIRED BEHAVIOR: Unicode dash normalization
  GoldenCase(
    name: 'Unicode dash normalization',
    input: 'мука – 500 г\n1. Взбить',
    expectedIngredients: ['мука - 500 г'],
    expectedSteps: ['взбить'],
    minQuality: ParseQuality.medium,
  ),

  // DESIRED BEHAVIOR: Noise filtering
  GoldenCase(
    name: 'Noise filtering',
    input: 'ПРИЯТНОГО АППЕТИТА\n1. Смешать яйца',
    expectedIngredients: [],
    expectedSteps: ['смешать яйца'],
    minQuality: ParseQuality.medium,
  ),
];
