# RecipeParser — GitHub Enforcement Policy

**Effective Date:** 2026-05-19  
**Status:** ACTIVE  
**Scope:** All changes to RecipeParser module

---

## 🔒 Branch Protection Rules (MANDATORY)

### Main Branch Protection

**Branch:** `main`

**Rules Enabled:**

1. ✅ **Require pull request reviews before merging**
   - Minimum 1 approval required
   - Dismiss stale pull request approvals when new commits are pushed
   - Require review from code owners (if configured)

2. ✅ **Require status checks to pass before merging**
   - Required checks:
     - `RecipeParser CI - Enforce Golden Tests` (parser-golden-tests job)
     - `RecipeParser CI - Enforce Golden Tests` (full-test-suite job)
     - `RecipeParser CI - Enforce Golden Tests` (contract-validation job)
   - Require branches to be up to date before merge

3. ✅ **Require branches to be up to date before merge**
   - Enabled

4. ✅ **Require code reviews before merging**
   - Minimum 1 approval
   - Dismiss stale approvals

5. ✅ **Restrict who can push to matching branches**
   - Only allow specified users/teams (optional)

---

## 🚫 Direct Push Policy

**DIRECT PUSH TO MAIN IS FORBIDDEN**

All changes to RecipeParser must go through:
1. Feature branch
2. Pull request
3. CI validation (golden tests MUST pass)
4. Code review (minimum 1 approval)
5. Merge to main

**Enforcement:** GitHub branch protection rules

---

## 🧪 CI Gate Requirements

### Golden Tests (BLOCKING)

**Requirement:** All 12 golden behavior tests MUST pass

**Trigger:** On every PR and push to main

**Failure Action:** Merge blocked

**Test File:** `test/parser/golden_behavior_test.dart`

### Full Test Suite (BLOCKING)

**Requirement:** All 44 tests MUST pass

**Trigger:** On every PR and push to main

**Failure Action:** Merge blocked

**Test Files:**
- `test/parser/golden_behavior_test.dart` (12 tests)
- `test/parser/recipe_parser_test.dart` (16 tests)
- `test/parser/recipe_parser_regression_test.dart` (12 tests)
- `test/parser_test.dart` (3 tests)
- `test/widget_test.dart` (1 test)

### Contract Validation (BLOCKING)

**Requirement:** All contract files MUST exist

**Trigger:** On every PR and push to main

**Failure Action:** Merge blocked

**Files Checked:**
- `lib/services/PARSER_CONTRACT.md`
- `lib/services/AGENT_INSTRUCTIONS.md`
- `test/parser/golden_behavior_dataset.dart`
- `test/parser/golden_behavior_test.dart`

---

## 📋 PR Workflow (MANDATORY)

### Step 1: Create Feature Branch
```bash
git checkout -b parser-improvement
```

### Step 2: Make Changes
- Edit parser files
- Run golden tests locally
- Ensure all tests pass

### Step 3: Commit with Tag
```bash
git commit -m "[PARSER-FIX] Fix ingredient detection

- What was broken
- How it's fixed
- Verified: golden_behavior_test.dart 12/12 PASS"
```

### Step 4: Push to Remote
```bash
git push origin parser-improvement
```

### Step 5: Create Pull Request
- Use PR template
- Fill in all required fields
- Reference issue if applicable

### Step 6: CI Runs Automatically
- Golden tests run
- Full test suite runs
- Contract validation runs

### Step 7: Code Review
- Minimum 1 approval required
- Address review comments
- Push additional commits if needed

### Step 8: Merge
- Merge button enabled only if:
  - All CI checks pass
  - At least 1 approval received
  - Branch is up to date with main

---

## 🚫 What's Forbidden

### Direct Push to Main
```bash
# ❌ FORBIDDEN
git push origin main

# ✅ REQUIRED
git push origin feature-branch
# Then create PR
```

### Bypassing CI
```bash
# ❌ FORBIDDEN
git push --no-verify

# ✅ REQUIRED
Let CI run and pass
```

### Merging Without Approval
```bash
# ❌ FORBIDDEN
Merge without code review

# ✅ REQUIRED
Get minimum 1 approval
```

### Merging with Failing Tests
```bash
# ❌ FORBIDDEN
Merge when CI fails

# ✅ REQUIRED
All tests must pass
```

---

## ✅ Enforcement Checklist

Before any change to RecipeParser:

- [ ] I created a feature branch (not main)
- [ ] I ran golden_behavior_test.dart locally
- [ ] All 12 golden tests pass
- [ ] I committed with proper tag ([PARSER-FIX], etc.)
- [ ] I pushed to remote
- [ ] I created a PR with template filled
- [ ] CI runs automatically
- [ ] All CI checks pass
- [ ] I got minimum 1 code review approval
- [ ] I merged through GitHub UI

---

## 🔐 Security Model

### What's Protected
- ✅ Main branch (direct push forbidden)
- ✅ Golden tests (merge gate)
- ✅ Contract files (validation gate)
- ✅ Code review (approval gate)

### What's Enforced
- ✅ PR-only workflow
- ✅ CI validation
- ✅ Code review
- ✅ Branch protection

### What's Blocked
- ❌ Direct push to main
- ❌ Merge without CI pass
- ❌ Merge without approval
- ❌ Merge with failing tests

---

## 📊 Enforcement Metrics

| Gate | Type | Status |
|------|------|--------|
| Branch protection | GitHub | ✅ ACTIVE |
| Golden tests | CI | ✅ ACTIVE |
| Full test suite | CI | ✅ ACTIVE |
| Contract validation | CI | ✅ ACTIVE |
| Code review | GitHub | ✅ ACTIVE |
| Commit message tags | Pre-commit | ✅ ACTIVE |

---

## 🎯 Governance Levels

### Level 1: Local (Pre-Commit)
- Pre-commit hook checks commit message tags
- Prevents accidental commits without tags

### Level 2: Remote (CI)
- GitHub Actions runs on every push/PR
- Blocks merge if tests fail
- Validates contract files

### Level 3: GitHub (Branch Protection)
- Direct push to main forbidden
- PR required for all changes
- Code review required
- CI must pass

---

## 📞 For Developers

### Normal Workflow
1. Create feature branch
2. Make changes
3. Commit with tag
4. Push to remote
5. Create PR
6. Wait for CI
7. Get approval
8. Merge

### If CI Fails
1. Check error message
2. Fix locally
3. Run golden tests
4. Commit and push
5. CI runs again
6. Merge when all pass

### If Review Rejected
1. Address comments
2. Make changes
3. Commit and push
4. Request re-review
5. Merge when approved

---

## 🔄 Continuous Enforcement

This policy is:
- ✅ Automatically enforced by GitHub
- ✅ Checked on every PR
- ✅ Checked on every push
- ✅ Non-bypassable (except by admins)

---

## 📝 Policy Updates

This policy can only be updated by:
- Repository maintainers
- With explicit approval
- Via PR to this file

---

**Status: ACTIVE AND ENFORCED** ✅

All RecipeParser changes are now governed by this policy at GitHub level.
