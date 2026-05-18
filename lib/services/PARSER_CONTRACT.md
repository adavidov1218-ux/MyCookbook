# RecipeParser — Semantic Extraction Contract v1

**Status:** STABLE  
**Last Updated:** 2026-05-18  
**Maintainer:** RecipeParser Module

---

## 📋 Contract Overview

RecipeParser implements a **Canonical Semantic Recipe Parsing Contract** that defines:
- What inputs are accepted
- What outputs are guaranteed
- What architectural constraints are immutable
- What changes are forbidden

This contract is **binding** and can only be changed via explicit architectural review.

---

## ✅ Guaranteed Behavior (Golden Dataset)

The parser MUST pass all 12 golden behavior tests:

1. **Standard recipe with quantities** — Explicit quantity-based ingredients + explicit steps
2. **Ingredients without quantity** — Semantic ingredient detection (соль, перец, зелень)
3. **Implicit steps without markers** — Imperative verb detection (смешать, добавить, взбить)
4. **Timestamp-prefixed steps** — Timestamp stripping (01:20 Смешать → смешать)
5. **Multiline step continuation** — Conjunction/preposition merging (и сахар → merged)
6. **Inline header stripping** — Header removal (Состав: мука → мука)
7. **Mixed explicit and implicit steps** — Both marker-based and verb-based steps
8. **No-qty ingredients with steps** — Semantic ingredients + implicit steps
9. **Complex recipe with all features** — All above features combined
10. **Bullet symbols cleanup** — Bullet removal (• мука → мука)
11. **Unicode dash normalization** — Dash conversion (– → -)
12. **Noise filtering** — Junk line removal

**Test File:** `test/parser/golden_behavior_dataset.dart`  
**Test Runner:** `test/parser/golden_behavior_test.dart`

---

## 🏗️ Immutable Architecture

### Pipeline Flow (CANNOT CHANGE)

```
RAW INPUT
    ↓
_preprocess()
  • Remove \r, non-breaking spaces
  • Remove bullet symbols
  • Strip timestamps
  • Strip inline headers
    ↓
_segment()
  • Classify lines: ingredient/step/noise
  • Detect continuation lines
    ↓
_extractIngredient()
  • Normalize for regex
  • Extract quantity/name
  • Store normalized text
    ↓
_extractSteps()
  • Match explicit markers
  • Match implicit verbs
  • Merge continuations
  • Store normalized text
    ↓
ParsedRecipe (canonical representation)
```

### Core Components (CANNOT REDESIGN)

| Component | Purpose | Status |
|-----------|---------|--------|
| `_preprocess()` | Text cleanup | STABLE |
| `_segment()` | Line classification | STABLE |
| `_extractIngredient()` | Ingredient parsing | STABLE |
| `_extractSteps()` | Step parsing | STABLE |
| `_isIngredient()` | Ingredient detection | STABLE |
| `_isStep()` | Step detection | STABLE |
| `_isContinuationLine()` | Continuation detection | STABLE |
| `BlockType` enum | Block classification | STABLE |
| `StringNormalizer` | Text normalization | STABLE |

---

## 🚫 Forbidden Changes

**NEVER:**
- Redesign segmentation architecture
- Add new pipeline stages
- Change BlockType enum
- Introduce ML/probabilistic logic
- Rewrite state machine
- Change normalization semantics
- Modify comparer architecture
- Add new extraction phases

**ONLY ALLOWED:**
- Bugfixes in existing methods
- Heuristic adjustments (regex, keyword lists)
- Precision/recall tuning
- Performance optimizations (no behavior change)

---

## 🔧 Allowed Modifications

### Type 1: Bugfix (Allowed)
```dart
// Example: Fix false positive in ingredient detection
if (hasFood || lower.contains('по вкусу')) {
  if (!_imperativeVerbsRegex.hasMatch(lower)) {
    return true; // ← Fix: exclude verbs
  }
}
```

### Type 2: Heuristic Adjustment (Allowed)
```dart
// Example: Add new cooking verb
static final _imperativeVerbsRegex = RegExp(
  r'^(смешать|добавить|взбить|...|новый_глагол)',
  caseSensitive: false,
);
```

### Type 3: Keyword Extension (Allowed)
```dart
// Example: Add new common ingredient
static final _commonIngredientsRegex = RegExp(
  r'(соль|перец|...|новый_ингредиент)',
  caseSensitive: false,
);
```

### Type 4: Architectural Change (FORBIDDEN)
```dart
// ❌ FORBIDDEN: Adding new pipeline stage
String _newStage(String text) { ... }

// ❌ FORBIDDEN: Changing BlockType
enum BlockType { header, ingredient, step, noise, НОВЫЙ_ТИП }

// ❌ FORBIDDEN: Redesigning segmentation
List<Block> _segment(List<String> lines) {
  // Completely new algorithm
}
```

---

## 📊 Metrics & Thresholds

### Test Coverage (MUST MAINTAIN)
- Golden behavior tests: **12/12 PASS** (100%)
- Recipe parser tests: **16/16 PASS** (100%)
- Regression tests: **12/12 PASS** (100%)
- Total: **40+ tests PASS** (100%)

### Code Size (MUST NOT EXCEED)
- Total regex patterns: **≤ 10** (currently 8)
- Helper methods: **≤ 10** (currently 7)
- Lines of code: **≤ 200** (currently ~160)

### Performance (MUST MAINTAIN)
- Parse time: **< 100ms** per recipe
- Memory: **< 1MB** per parse
- No blocking operations

---

## 🔍 Change Review Checklist

Before ANY modification to RecipeParser:

- [ ] Is this a bugfix for a failing golden test?
- [ ] Does it change architecture? (If YES → FORBIDDEN)
- [ ] Does it add new pipeline stage? (If YES → FORBIDDEN)
- [ ] Does it modify BlockType? (If YES → FORBIDDEN)
- [ ] Is it a local heuristic adjustment? (If YES → ALLOWED)
- [ ] Will it break any golden tests? (If YES → FORBIDDEN)
- [ ] Is the change < 10 lines? (If NO → needs review)
- [ ] Have you run golden_behavior_test.dart? (If NO → REQUIRED)

---

## 📝 Change Log

### v1.0 (2026-05-18)
- ✅ Unified normalization pipeline
- ✅ Semantic ingredient detection
- ✅ Implicit step detection
- ✅ Timestamp stripping
- ✅ Inline header removal
- ✅ Continuation line merging
- ✅ 12/12 golden tests passing
- ✅ Contract established

---

## 🎯 Future Work (Out of Scope)

These items require EXPLICIT ARCHITECTURAL REVIEW:

- [ ] ML-based ingredient classification
- [ ] Probabilistic step ordering
- [ ] Multi-language support
- [ ] Nested recipe parsing
- [ ] Ingredient substitution detection
- [ ] Cooking time extraction
- [ ] Difficulty level inference

**To propose:** Create separate issue with "ARCHITECTURE" label.

---

## 📞 Questions?

If you're unsure whether a change is allowed:
1. Check this contract
2. Run golden_behavior_test.dart
3. If tests pass → likely OK
4. If tests fail → FORBIDDEN
5. If unsure → ask for architectural review

**Remember:** Parser is STABLE. Treat it like a library contract.
