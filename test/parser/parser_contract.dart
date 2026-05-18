/// DEFINITION OF CONTRACT FOR RecipeParser
/// ---------------------------------------------------
/// 1. Section Detection: 
///    - Если Section == None: 
///      - Default: Ingredient (если строка содержит [цифра + unit] ИЛИ [цифра + foodWord])
///      - Step: только если содержит [marker] ИЛИ [cookingVerb]
///    - Если Section == Ingredients:
///      - Переключается в Steps только при обнаружении маркера шага или verb-based триггера.
/// 2. Ingredient Rules:
///    - Quantity/Unit/Food word detection (positive signals).
///    - Junk patterns exclusion (negative signals).
/// 3. Step Rules:
///    - Imperative verbs (смешать, добавить, etc).
///    - Marker recognition (1., 1), 1., etc).
/// 4. Junk Handling:
///    - Удаляется на этапе Normalization.
/// 5. Quality Classification:
///    - High = Ingredients > 2 AND Steps > 1 AND !fallback.
///    - Medium = !empty.
///    - Low = empty.
class ParserContract {}
