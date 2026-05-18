import 'package:mycookbook_gemini/domain/models/parsed_recipe.dart';
import 'package:mycookbook_gemini/services/normalizer.dart';

class RecipeParser {
  static final _stepMarkerRegex = RegExp(r'^(\d+[.)]|шаг\s*\d+|👉|➡|1\.)\s*', caseSensitive: false);
  static final _headerRegex = RegExp(
    r'^\s*(ингредиент|состав|продукты|приготовление|способ|как готовить|шаг)\s*:?\s*$',
    caseSensitive: false,
  );
  static final _timestampRegex = RegExp(r'^\d{1,2}:\d{2}\s+');
  static final _imperativeVerbsRegex = RegExp(
    r'^(смешать|добавить|взбить|нарезать|жарить|выпекать|варить|тушить|запечь|посолить|поперчить|перемешать|вылить|положить|разогреть|охладить|процедить|натереть|нарезать|нашинковать|раскатать|сложить|завернуть|подавать)',
    caseSensitive: false,
  );
  static final _commonIngredientsRegex = RegExp(
    r'(соль|перец|сахар|мука|масло|молоко|яйца?|вода|уксус|специи|травы|зелень|чеснок|лук|помидор|огурец|морковь|картофель|капуста|свекла|редис|редька|репа|пастернак|сельдерей|петрушка|укроп|базилик|орегано|тимьян|розмарин|лавр|корица|гвоздика|мускатный|имбирь|куркума|паприка|кориандр|тмин|анис)',
    caseSensitive: false,
  );
  final StringNormalizer _normalizer = StringNormalizer();
  
  ParsedRecipe parse({required String text, required String fallbackTitle}) {
    final cleanedText = _preprocess(text);
    final lines = cleanedText.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    final blocks = _segment(lines);
    final ingredients = blocks.where((b) => b.type == BlockType.ingredient).expand((b) => b.lines).map(_extractIngredient).toList();
    final steps = _extractSteps(blocks.where((b) => b.type == BlockType.step).toList());

    return ParsedRecipe(
      title: fallbackTitle,
      ingredients: ingredients,
      steps: steps,
      diagnostics: ParseDiagnostics(),
      rawText: text
    );
  }

  String _preprocess(String text) {
    text = text.replaceAll('\r', '').replaceAll('\u00A0', ' ');
    final lines = text.split('\n');
    final cleanedLines = lines.map((line) {
      // Remove bullet symbols
      line = line.replaceAll(RegExp(r'^[\s•●▪◦○■□]+'), '');
      // Remove timestamps from line start
      line = line.replaceAll(_timestampRegex, '');
      // Strip inline headers (Состав:, Ингредиенты:, etc.)
      line = line.replaceAll(RegExp(r'^(состав|ингредиент|продукты|рецепт|приготовление|способ|как готовить):\s*', caseSensitive: false), '');
      return line;
    }).toList();
    return cleanedLines.join('\n');
  }

  List<Block> _segment(List<String> lines) {
    List<Block> blocks = [];
    if (lines.isEmpty) return blocks;

    BlockType? currentType;
    List<String> currentLines = [];

    for (var line in lines) {
      if (_headerRegex.hasMatch(line)) continue;

      BlockType type;
      // Continuation lines stay with current block type
      if (currentType != null && _isContinuationLine(line)) {
        type = currentType;
      } else if (_isStep(line)) {
        type = BlockType.step;
      } else if (_isIngredient(line)) {
        type = BlockType.ingredient;
      } else {
        type = BlockType.noise;
      }

      if (currentType == null) {
        currentType = type;
        currentLines.add(line);
      } else if (type == currentType) {
        currentLines.add(line);
      } else {
        blocks.add(Block(currentType, List.from(currentLines)));
        currentLines.clear();
        currentType = type;
        currentLines.add(line);
      }
    }
    if (currentLines.isNotEmpty && currentType != null) {
      blocks.add(Block(currentType, currentLines));
    }
    return blocks;
  }

  Ingredient _extractIngredient(String line) {
    final normalized = _normalizer.normalize(line);
    final reg = RegExp(r'^(\d+\s?[а-яёa-z\.]+)\s+(.*)', caseSensitive: false);
    final match = reg.firstMatch(normalized);
    if (match != null) return Ingredient(match.group(2)!.trim(), quantity: match.group(1)!.trim());
    return Ingredient(_normalizer.normalize(line.trim()));
  }

  List<Step> _extractSteps(List<Block> blocks) {
    final steps = <Step>[];
    for (var block in blocks) {
      for (var line in block.lines) {
        if (_stepMarkerRegex.hasMatch(line)) {
          final description = line.replaceAll(_stepMarkerRegex, '').trim();
          steps.add(Step(steps.length + 1, _normalizer.normalize(description)));
        } else if (_imperativeVerbsRegex.hasMatch(line)) {
          // Implicit step (no marker)
          steps.add(Step(steps.length + 1, _normalizer.normalize(line.trim())));
        } else if (steps.isNotEmpty) {
          // Continuation line: merge with previous step
          final last = steps.removeLast();
          final mergedDescription = '${last.description} ${line.trim()}';
          steps.add(Step(last.order, _normalizer.normalize(mergedDescription)));
        }
      }
    }
    return steps;
  }

  bool _isIngredient(String line) {
    final lower = line.toLowerCase();
    final units = ['г', 'гр', 'кг', 'мл', 'л', 'шт', 'ст.л', 'ч.л', 'стакан'];
    final hasDigit = RegExp(r'\d').hasMatch(lower);
    final hasUnit = units.any((u) => lower.contains(u));
    final hasFood = _commonIngredientsRegex.hasMatch(lower);

    // Quantity-based ingredient detection (original logic)
    if (hasDigit && (hasUnit || hasFood)) return true;

    // Semantic ingredient detection (no quantity)
    // Match common ingredients or phrases like "по вкусу"
    if (hasFood || lower.contains('по вкусу') || lower.contains('по желанию')) {
      // But exclude lines that look like imperative verbs (steps)
      if (!_imperativeVerbsRegex.hasMatch(lower)) {
        return true;
      }
    }

    return false;
  }

  bool _isStep(String line) {
    // Explicit step markers
    if (_stepMarkerRegex.hasMatch(line)) return true;

    // Implicit step detection: lines starting with imperative verbs
    if (_imperativeVerbsRegex.hasMatch(line)) return true;

    return false;
  }

  bool _isContinuationLine(String line) {
    final lower = line.toLowerCase();
    // Lines starting with conjunctions are definitely continuations
    if (lower.startsWith('и ') || lower.startsWith('или ') || lower.startsWith('а ')) return true;
    // Lines starting with prepositions
    if (lower.startsWith('до ') || lower.startsWith('на ') || lower.startsWith('в ')) return true;
    // Very short lines (1 word) that don't look like ingredients or steps
    final words = line.split(' ');
    if (words.length == 1) {
      // Single word: check if it's a known ingredient or verb
      if (_commonIngredientsRegex.hasMatch(lower) || _imperativeVerbsRegex.hasMatch(lower)) {
        return false; // It's an ingredient or step, not continuation
      }
      return true; // Unknown single word is likely continuation
    }
    return false;
  }
}

enum BlockType { header, ingredient, step, noise }

class Block {
  final BlockType type;
  final List<String> lines;
  Block(this.type, this.lines);
}
