---
name: commit
description: Create meaningful Git commits from current changes. Use when making a Git commit, or when asked to commit changes.
---

## Prerequisites

You must verify all of the following conditions before proceeding:

- Current directory is a Git repository
- Repository is not in a conflicted merge state
- Changes exist (staged, unstaged, or untracked files)

If any condition is not met:

- Stop the process immediately
- Report which condition failed

## Execution Phases

When all conditions are met, execute these phases in order:

### Phase 1: Repository Analysis

Analyze current repository state:

```bash
# Check repository status
git status --porcelain
```

Extract and categorize:

- Staged files (ready to commit)
- Unstaged files (modified, added, deleted)
- Untracked files (new files to be added)

### Phase 2: File Staging

**If no staged files exist:**

Stage all unstaged and untracked files:

```bash
git add -A
```

**If staged files already exist:**

- Proceed with existing staged files
- User has already chosen what to commit

### Phase 3: Commit Execution

Execute commit process:

1. **Generate Conventional Commits message:**
   - Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification
   - Include breaking change indicators if applicable
   - Keep first line under 72 characters

2. **Create commit with proper attribution:**

   ```bash
   git commit -m "$(cat <<'EOF'
   <type>: <describe the purpose of change in brief>

   <optional body to describe what, why, and how in brief>

   🤖 Generated with [Claude Code](https://claude.ai/code)

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"

   <optional footer with breaking changes>
   ```

3. **Verify commit success:**
   ```bash
   git log --oneline -1
   ```

### Phase 4: Complete

Provide the summary to the user:

- Success/failure status
- Commit hash and message
- Files included in the commit
- Any remaining unstaged/untracked files

## Error Handling

- If pre-commit hooks fail, do not retry to commit but just report to the user
- Never push or override safety checks (e.g, `git push` or `git commit --no-verify`)
