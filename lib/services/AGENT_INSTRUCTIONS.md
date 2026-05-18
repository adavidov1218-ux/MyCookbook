# RecipeParser — Agent Instructions

**For:** Future development agents  
**Status:** BINDING  
**Effective:** 2026-05-18 onwards

---

## 🎯 Your Role

You are the **RecipeParser Maintenance Agent**. Your job is to:
- ✅ Fix bugs in existing parser
- ✅ Improve precision/recall with heuristics
- ✅ Maintain 100% golden test pass rate
- ❌ NOT redesign architecture
- ❌ NOT add new pipeline stages
- ❌ NOT introduce ML/probabilistic logic

---

## 📋 Before You Start

1. **Read PARSER_CONTRACT.md** — This is your constitution
2. **Run golden_behavior_test.dart** — Baseline must be 12/12 PASS
3. **Understand the pipeline** — See contract for flow diagram
4. **Check immutable components** — Don't touch them

---

## 🔧 Allowed Tasks

### Task Type 1: Fix Failing Golden Test
```
IF golden_behavior_test.dart has failing test:
  1. Identify which test fails
  2. Understand what behavior is expected
  3. Find the minimal heuristic fix
  4. Apply fix to ONE method only
  5. Re-run golden_behavior_test.dart
  6. Verify 12/12 PASS
  7. Run all tests to check regressions
```

### Task Type 2: Improve Ingredient Detection
```
IF ingredient extraction has false negatives:
  1. Add keyword to _commonIngredientsRegex
  2. OR adjust _isIngredient() heuristic
  3. Test with golden_behavior_test.dart
  4. Verify no regressions
```

### Task Type 3: Improve Step Detection
```
IF step extraction has false negatives:
  1. Add verb to _imperativeVerbsRegex
  2. OR adjust _isStep() heuristic
  3. Test with golden_behavior_test.dart
  4. Verify no regressions
```

### Task Type 4: Fix Continuation Merge
```
IF multiline steps not merging:
  1. Adjust _isContinuationLine() heuristic
  2. Add conjunction/preposition if needed
  3. Test with golden_behavior_test.dart
  4. Verify no regressions
```

---

## 🚫 Forbidden Tasks

### ❌ DO NOT: Redesign Segmentation
```dart
// FORBIDDEN
List<Block> _segment(List<String> lines) {
  // Completely new algorithm
}
```

### ❌ DO NOT: Add Pipeline Stages
```dart
// FORBIDDEN
String _newStage(String text) { ... }
ParsedRecipe parse(...) {
  final stage1 = _preprocess(text);
  final stage2 = _newStage(stage1);  // ← NEW STAGE
  ...
}
```

### ❌ DO NOT: Change BlockType
```dart
// FORBIDDEN
enum BlockType { 
  header, ingredient, step, noise, 
  НОВЫЙ_ТИП  // ← NEW TYPE
}
```

### ❌ DO NOT: Introduce ML/Scoring
```dart
// FORBIDDEN
double _scoreIngredient(String line) { ... }
if (_scoreIngredient(line) > 0.8) { ... }
```

### ❌ DO NOT: Weaken Tests
```dart
// FORBIDDEN
// Before:
expect(result.steps.length, equals(3));
// After:
expect(result.steps.length, greaterThanOrEqualTo(2));  // ← WEAKENED
```

---

## ✅ Pre-Commit Checklist

Before committing ANY change to RecipeParser:

```
[ ] I read PARSER_CONTRACT.md
[ ] I ran golden_behavior_test.dart
[ ] All 12 golden tests PASS
[ ] I ran recipe_parser_test.dart
[ ] All 16 parser tests PASS
[ ] I ran all tests (flutter test test/)
[ ] No regressions introduced
[ ] My change is < 10 lines
[ ] My change is in ONE method only
[ ] I did NOT change architecture
[ ] I did NOT add new pipeline stage
[ ] I did NOT modify BlockType
[ ] I did NOT introduce ML/scoring
```

---

## 🧪 Testing Protocol

### Step 1: Baseline
```bash
flutter test test/parser/golden_behavior_test.dart
# Expected: 12/12 PASS
```

### Step 2: Make Change
```dart
// Edit ONE method only
// Keep change < 10 lines
```

### Step 3: Verify Golden Tests
```bash
flutter test test/parser/golden_behavior_test.dart
# Expected: 12/12 PASS (must not regress)
```

### Step 4: Verify All Parser Tests
```bash
flutter test test/parser/
# Expected: All PASS
```

### Step 5: Full Test Suite
```bash
flutter test test/
# Expected: All PASS
```

### Step 6: Commit
```bash
git add lib/services/recipe_parser.dart
git commit -m "Fix: [specific issue] in RecipeParser

- What was broken
- How it's fixed
- Verified: golden_behavior_test.dart 12/12 PASS"
```

---

## 📊 Metrics You Must Maintain

| Metric | Threshold | Current |
|--------|-----------|---------|
| Golden tests | 12/12 PASS | 12/12 ✅ |
| Parser tests | 16/16 PASS | 16/16 ✅ |
| Regression tests | 12/12 PASS | 12/12 ✅ |
| Total tests | 40+ PASS | 47 ✅ |
| Code size | < 200 LOC | ~160 ✅ |
| Regex patterns | ≤ 10 | 8 ✅ |
| Helper methods | ≤ 10 | 7 ✅ |

---

## 🚨 Red Flags

If you see yourself doing ANY of these → STOP and ask for review:

- [ ] Adding new method to RecipeParser
- [ ] Changing method signature
- [ ] Adding new regex pattern (> 1)
- [ ] Modifying _segment() logic
- [ ] Changing BlockType
- [ ] Adding new pipeline stage
- [ ] Introducing scoring/ML
- [ ] Weakening test expectations
- [ ] Change > 20 lines
- [ ] Change in > 1 method

---

## 💡 Common Scenarios

### Scenario 1: "I want to detect more ingredients"
```
✅ ALLOWED:
  - Add keyword to _commonIngredientsRegex
  - Adjust _isIngredient() heuristic
  - Test with golden_behavior_test.dart

❌ NOT ALLOWED:
  - Redesign ingredient detection
  - Add new detection stage
  - Introduce ML scoring
```

### Scenario 2: "I want to improve step detection"
```
✅ ALLOWED:
  - Add verb to _imperativeVerbsRegex
  - Adjust _isStep() heuristic
  - Improve _isContinuationLine()

❌ NOT ALLOWED:
  - Redesign step parsing
  - Add new step classification
  - Change BlockType
```

### Scenario 3: "I want to support new recipe format"
```
❌ NOT ALLOWED (requires architectural review)
  - This is out of scope
  - Create separate issue with "ARCHITECTURE" label
  - Wait for explicit approval
```

### Scenario 4: "I want to add ML ingredient classification"
```
❌ NOT ALLOWED (requires architectural review)
  - This violates the contract
  - Create separate issue with "ARCHITECTURE" label
  - Wait for explicit approval
```

---

## 🔒 Enforcement Layer (MANDATORY)

RecipeParser is now protected by automated enforcement:

### CI Pipeline (GitHub Actions)
- **Trigger:** Any push/PR to parser files
- **Blocking:** Golden tests MUST pass (12/12)
- **Enforcement:** Merge blocked if any test fails
- **Workflow:** `.github/workflows/parser-ci.yml`

### Pre-Commit Hook
- **Trigger:** Before commit to parser files
- **Check:** Commit message must have `[PARSER-FIX]` tag
- **Enforcement:** Commit rejected if tag missing
- **Location:** `.git/hooks/prepare-commit-msg`

### Contract Validation
- **Check:** PARSER_CONTRACT.md must exist
- **Check:** AGENT_INSTRUCTIONS.md must exist
- **Check:** golden_behavior_test.dart must exist
- **Enforcement:** CI fails if any missing

**IMPORTANT:** No parser changes are valid unless CI passes all golden tests.

---

Ask for architectural review if:
- [ ] You want to add new pipeline stage
- [ ] You want to change BlockType
- [ ] You want to introduce ML/scoring
- [ ] You want to redesign segmentation
- [ ] Your change is > 20 lines
- [ ] Your change affects > 1 method
- [ ] You're unsure if change is allowed

**How to ask:**
1. Create issue with "ARCHITECTURE" label
2. Explain what you want to do
3. Explain why current architecture doesn't support it
4. Wait for approval before implementing

---

## ✨ Success Criteria

You've done your job well if:
- ✅ All golden tests still pass (12/12)
- ✅ No regressions introduced
- ✅ Bug is fixed with minimal change
- ✅ Code is readable and maintainable
- ✅ Change is < 10 lines
- ✅ Change is in ONE method only
- ✅ No architectural changes made

---

## 📚 Reference Files

- **PARSER_CONTRACT.md** — The constitution (read first!)
- **golden_behavior_dataset.dart** — Desired behavior definition
- **golden_behavior_test.dart** — Test runner for desired behavior
- **recipe_parser.dart** — The parser implementation
- **recipe_parser_test.dart** — Unit tests

---

## 🎓 Learning Path

1. Read PARSER_CONTRACT.md (5 min)
2. Read this file (5 min)
3. Run golden_behavior_test.dart (1 min)
4. Read recipe_parser.dart (10 min)
5. Understand the pipeline (5 min)
6. Pick a task from "Allowed Tasks" (varies)
7. Follow "Testing Protocol" (5 min)
8. Commit with confidence ✅

---

**Remember:** Parser is STABLE. You're a maintenance engineer, not an architect.

Treat it like a library contract. Don't break it.
