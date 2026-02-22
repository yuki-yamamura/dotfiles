---
description: Open and initialize pull request from GitHub Issue (/open-pr <issue_url>)
---

Create a new pull request that addresses the Issue provided by the user.

## Prerequisites

You must verify all of the following conditions before proceeding:

- The user provided a GitHub Issue link
- No untracked or unstaged files exist in the working directory without `./tmp` directory

If any condition is not met:

- Stop the process immediately
- Notify the user which condition failed

## Execution Phases

When all conditions are met, execute these phases in order:

### Phase 1: Extract Issue Information

Parse the GitHub Issue link to extract:

- Repository owner and name
- Issue number: Store as `issue_id`
- Issue title: Store as `issue_title` (retrieve via `gh issue view`)
- Available labels: Store as `labels` (retrieve via `gh label list`)

### Phase 2: Ask Conditional information

Ask the user these conditional information using the AskUserQuestion tool:

- Whether a working branch is already created or not
- PR title (use the same title as issue / type)
- PR label: (select from existing labels, optional - omit `--label` flag if not selected)

### Phase 3: Get Current Branch

Determine the current branch:

```bash
current_branch=$(git branch --show-current)
```

### Phase 4: Create Working Branch If Necessary

Create a new working branch if it's not created yet:

- Branch name: `feature/#<issue_id>`
- Checkout from: `current_branch`

```bash
# If working branch already exists, switch to it
git switch feature/#<issue_id>
working_branch=$(git branch --show-current)

# Or create new one
git switch -c feature/#<issue_id>
git commit --allow-empty -m 'chore: start <working_branch>'
working_branch=$(git branch --show-current)
```

### Phase 5: Create Pull Request

1. **Push branch to remote**

```bash
git push -u origin <working_branch>
```

2. **Create draft PR with title and template**

```bash
# The label flag is optional. Omit it entirely if then user didn't select a label.
if [ -f ".github/pull_request_template.md" ]; then
  gh pr create \
    --assignee "@me" \
    --base <current_branch> \
    --draft \
    --title "【#<issue_id>】<pr_title>" \
    --body-file .github/pull_request_template.md \
    --label "<label_name>"
else
  gh pr create \
    --assignee "@me" \
    --base <current_branch> \
    --draft \
    --title "【#<issue_id>】<pr_title>" \
    --body "" \
    --label "<label_name>"
fi
```

### Phase 6: Complete

Report the summary to the user including:

- Issue link provided by the user
- Pull Request link that has been created
