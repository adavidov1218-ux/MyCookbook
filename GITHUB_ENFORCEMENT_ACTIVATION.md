# RecipeParser — GitHub Enforcement Activation Guide

**Date:** 2026-05-19  
**Status:** READY FOR ACTIVATION  
**Purpose:** Convert local enforcement to GitHub-level enforcement

---

## 🎯 What This Enables

After following this guide, RecipeParser will have:

✅ **Branch Protection** — Direct push to main forbidden  
✅ **PR-Only Workflow** — All changes require pull request  
✅ **CI Gates** — Golden tests block merge  
✅ **Code Review** — Minimum 1 approval required  
✅ **Automated Enforcement** — GitHub enforces all rules  

---

## 📋 Activation Steps (For Repository Admin)

### Step 1: Go to Repository Settings

1. Navigate to your GitHub repository
2. Click **Settings** (top right)
3. Click **Branches** (left sidebar)

### Step 2: Add Branch Protection Rule

1. Click **Add rule**
2. Branch name pattern: `main`
3. Enable the following:

#### ✅ Require a pull request before merging
- [x] Require pull request reviews before merging
- [x] Dismiss stale pull request approvals when new commits are pushed
- [x] Require review from code owners (if CODEOWNERS file exists)
- Required approving reviews: **1**

#### ✅ Require status checks to pass before merging
- [x] Require branches to be up to date before merging
- [x] Require status checks to pass before merging

**Select these status checks:**
- `RecipeParser CI - Enforce Golden Tests / parser-golden-tests`
- `RecipeParser CI - Enforce Golden Tests / full-test-suite`
- `RecipeParser CI - Enforce Golden Tests / contract-validation`

#### ✅ Other protections
- [x] Restrict who can push to matching branches (optional)
- [x] Allow force pushes (optional, recommended: disabled)
- [x] Allow deletions (optional, recommended: disabled)

### Step 3: Save Rule

Click **Create** to save the branch protection rule.

---

## 🔍 Verification Checklist

After activation, verify:

- [ ] Direct push to main is rejected
- [ ] PR creation is required for all changes
- [ ] CI runs automatically on PR creation
- [ ] Merge button is disabled until CI passes
- [ ] Merge button is disabled until approval received
- [ ] PR template appears when creating PR

---

## 🧪 Test the Enforcement

### Test 1: Try Direct Push (Should Fail)
```bash
git checkout main
echo "test" > test.txt
git add test.txt
git commit -m "test"
git push origin main
# Expected: REJECTED by GitHub
```

### Test 2: Create PR (Should Work)
```bash
git checkout -b test-pr
echo "test" > test.txt
git add test.txt
git commit -m "[PARSER-FIX] test"
git push origin test-pr
# Go to GitHub and create PR
# Expected: CI runs, merge blocked until CI passes
```

### Test 3: Verify CI Gate
- Wait for CI to complete
- Verify merge button is disabled if tests fail
- Verify merge button is enabled if tests pass

### Test 4: Verify Code Review Gate
- Even if CI passes, merge button should be disabled
- Request approval from another user
- After approval, merge button should be enabled

---

## 📊 Enforcement Architecture

```
Developer
    ↓
Feature Branch
    ↓
Pull Request
    ↓
GitHub Checks:
  ├─ CI Pipeline (golden tests MUST pass)
  ├─ Contract Validation (files MUST exist)
  └─ Status Checks (all MUST pass)
    ↓
Code Review Gate
  └─ Minimum 1 approval required
    ↓
Branch Protection
  └─ Merge allowed only if all gates pass
    ↓
Main Branch
```

---

## 🚫 What's Now Impossible

After activation:

| Action | Status |
|--------|--------|
| Direct push to main | ❌ BLOCKED |
| Merge without CI pass | ❌ BLOCKED |
| Merge without approval | ❌ BLOCKED |
| Merge with failing tests | ❌ BLOCKED |
| Bypass branch protection | ❌ BLOCKED (except admins) |

---

## ✅ What's Now Required

After activation:

| Action | Status |
|--------|--------|
| Create feature branch | ✅ REQUIRED |
| Create pull request | ✅ REQUIRED |
| Pass CI (golden tests) | ✅ REQUIRED |
| Get code review approval | ✅ REQUIRED |
| Merge through GitHub UI | ✅ REQUIRED |

---

## 📋 Documentation Files

| File | Purpose |
|------|---------|
| GOVERNANCE_ENFORCEMENT.md | Branch protection rules and policy |
| .github/pull_request_template.md | PR template with checklist |
| .github/workflows/parser-ci.yml | CI pipeline definition |
| PARSER_CONTRACT.md | Semantic contract |
| AGENT_INSTRUCTIONS.md | Maintenance guidelines |

---

## 🔐 Security Model

### Layers of Protection

1. **Pre-Commit Hook** (Local)
   - Requires commit message tags
   - Prevents accidental commits

2. **CI Pipeline** (Remote)
   - Runs golden tests
   - Validates contract files
   - Blocks merge on failure

3. **Branch Protection** (GitHub)
   - Requires PR for all changes
   - Requires code review
   - Requires CI pass
   - Blocks direct push

4. **Code Review** (Human)
   - Minimum 1 approval
   - Prevents bad changes

---

## 📞 For Developers After Activation

### Normal Workflow
```bash
# 1. Create feature branch
git checkout -b parser-improvement

# 2. Make changes
# ... edit files ...

# 3. Run tests locally
flutter test test/parser/golden_behavior_test.dart

# 4. Commit with tag
git commit -m "[PARSER-FIX] Fix ingredient detection"

# 5. Push to remote
git push origin parser-improvement

# 6. Create PR on GitHub
# (Use PR template)

# 7. Wait for CI
# (GitHub Actions runs automatically)

# 8. Get approval
# (Reviewer approves)

# 9. Merge
# (Click merge button on GitHub)
```

### If CI Fails
```bash
# 1. Check error message
# 2. Fix locally
# 3. Run tests
# 4. Commit and push
# 5. CI runs again
# 6. Merge when all pass
```

---

## ⚠️ Important Notes

### For Repository Admins
- Only admins can bypass branch protection
- Use this power carefully
- Document any bypasses

### For Developers
- You cannot push directly to main
- You cannot merge without approval
- You cannot merge without CI pass
- This is intentional and necessary

### For Reviewers
- Review all PRs carefully
- Check that tests pass
- Check that contract is respected
- Approve only if confident

---

## 🎯 Final State

After activation, RecipeParser will be:

✅ **Fully Protected** — Branch protection active  
✅ **CI-Gated** — Golden tests block merge  
✅ **PR-Controlled** — All changes via PR  
✅ **Review-Required** — Code review mandatory  
✅ **Automatically Enforced** — GitHub enforces all rules  

---

## 📚 Reference

- **GitHub Docs:** https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches
- **Branch Protection:** https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches
- **Status Checks:** https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches#about-branch-protection-rules

---

**Status: READY FOR ACTIVATION** ✅

Follow the steps above to activate GitHub enforcement for RecipeParser.
