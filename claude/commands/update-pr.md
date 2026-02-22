---
description: Update existing pull request body (/update-pr)
---

Update existing pull request body with properly formatted description in Japanese.
Follows the pull request template if available; otherwise uses minimal required format.

## Execution Conditions

You must verify all of the following conditions before proceeding:

- Pull Request exists for the current branch (can be draft or open)
- No untracked or unstaged files exist in the working directory without `./tmp` directory

If any condition is not met:

- Stop the process immediately
- Notify the user which condition failed

## Execution Phases

When all conditions are met, execute these phases in order:

### Phase 1: Verify Pull Request Existence and Get Information

```bash
# Get current branch
current_branch=$(git branch --show-current)

# Check if pull request exists for current branch
pr_number=$(gh pr list --head "$current_branch" --state all --json number --jq '.[0].number')

# Verify pull request exists
if [ "$pr_number" = "null" ] || [ -z "$pr_number" ]; then
    exit 1
fi

# Get base branch
base_branch=$(gh pr view "$pr_number" --json baseRefName --jq '.baseRefName')
```

### Phase 2: Collect Pull Request Information

Use the `pr-diff` skill to collect changed files and diff from the pull request.

### Phase 3: Check for Pull Request Template

```bash
if [ -f ".github/pull_request_template.md" ]; then
    # Read and parse template
    template_exists=true
else
    template_exists=false
fi
```

### Phase 4: Generate Pull Request Body

**IMPORTANT**: Write ALL content in Japanese for human readability

- Follow template structure exactly
  - Fill in only sections that exist in a template
  - Do not add extra information beyond template requirements
  - Include required content within appropriate template sections
- If you summarize what changes, use commit hashes so that reviewers can read them one by one (e.g, `<commit_hash>: <short_description>`)
- Do not fill in the checklist. That is the user's responsibility.

### Phase 5: Update Pull Request Body

```bash
gh pr edit "$pr_number" --body "$(cat <<'EOF'
[Generated PR body content]
EOF
)"
```

### Phase 6: Complete

Provide the summary to the user including the pull request URL.
