## 🧩 Change Type

- [ ] Bugfix (fixes existing issue)
- [ ] Parser heuristic change (improves detection)
- [ ] Documentation only (no code changes)
- [ ] CI / infrastructure (workflow, hooks, etc.)
- [ ] Other (please describe)

---

## 📝 Description

**What does this PR do?**

<!-- Describe the changes and why they're needed -->

---

## ⚠️ Parser Impact

- [ ] This PR modifies RecipeParser logic
- [ ] This PR modifies test expectations
- [ ] This PR does NOT modify parser

**If parser modified, explain:**
<!-- What heuristics changed? What behavior improved? -->

---

## 🧪 Testing

**Local verification:**
- [ ] `flutter test test/parser/golden_behavior_test.dart` passes (12/12)
- [ ] `flutter test test/parser/recipe_parser_test.dart` passes (16/16)
- [ ] `flutter test test/parser/recipe_parser_regression_test.dart` passes (12/12)
- [ ] `flutter test test/` passes (all 44 tests)

**CI will verify:**
- ✅ Golden behavior tests (12/12 MUST pass)
- ✅ Full test suite (44/44 MUST pass)
- ✅ Contract validation (files MUST exist)

---

## 🔒 Contract Compliance

- [ ] PARSER_CONTRACT.md respected (no architectural changes)
- [ ] No new pipeline stages introduced
- [ ] No BlockType enum changes
- [ ] No segmentation redesign
- [ ] Only heuristic adjustments made

**If architectural change needed:**
<!-- Explain why current architecture doesn't support this -->
<!-- This requires explicit review and approval -->

---

## 📋 Checklist

- [ ] I created a feature branch (not direct push to main)
- [ ] I used proper commit tag: `[PARSER-FIX]`, `[PARSER-IMPROVEMENT]`, etc.
- [ ] I ran all tests locally and they pass
- [ ] I filled in this PR template completely
- [ ] I did not weaken any test expectations
- [ ] I did not introduce architectural changes
- [ ] I did not bypass CI or pre-commit hooks

---

## 🔗 Related Issues

<!-- Link to related issues if applicable -->
Fixes #
Related to #

---

## 📸 Screenshots / Examples

<!-- If applicable, add screenshots or examples of the change -->

---

## 🚀 Deployment Notes

<!-- Any special deployment considerations? -->

---

## ✨ Additional Context

<!-- Anything else reviewers should know? -->

---

**Note:** This PR will be automatically checked by:
1. GitHub Actions CI (golden tests MUST pass)
2. Contract validation (files MUST exist)
3. Code review (minimum 1 approval required)

Merge is only allowed if all checks pass.
