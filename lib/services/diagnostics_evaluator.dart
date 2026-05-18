import 'package:mycookbook_gemini/domain/models/parsed_recipe.dart';

class DiagnosticsEvaluator {
  ParseDiagnostics evaluate(List<Ingredient> ingredients, List<Step> steps) {
    final quality = (ingredients.length >= 3 && steps.length >= 2) 
        ? ParseQuality.high 
        : (ingredients.isNotEmpty || steps.isNotEmpty) 
            ? ParseQuality.medium 
            : ParseQuality.low;
            
    return ParseDiagnostics(quality: quality);
  }
}
