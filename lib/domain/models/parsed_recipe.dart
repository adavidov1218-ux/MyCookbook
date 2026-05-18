enum ParseQuality { high, medium, low }

class Ingredient {
  final String name;
  final String quantity;
  Ingredient(this.name, {this.quantity = ''});
  @override
  String toString() => '$name $quantity'.trim();
}

class Step {
  final int order;
  final String description;
  Step(this.order, this.description);
}

class ParseDiagnostics {
  ParseQuality quality = ParseQuality.low;
  bool usedFallback = false;
  List<String> warnings = [];
  ParseDiagnostics({this.quality = ParseQuality.low, this.usedFallback = false, this.warnings = const []});
}

class ParsedRecipe {
  final String title;
  final List<Ingredient> ingredients;
  final List<Step> steps;
  final ParseDiagnostics diagnostics;
  final String rawText;

  ParsedRecipe({
    required this.title, 
    required this.ingredients, 
    required this.steps, 
    required this.diagnostics, 
    required this.rawText
  });
}
