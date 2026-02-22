---
name: pr-diff
description: Collect information from a pull request and Git histories. Use when reviewing or describing a pull request
---

## Prerequisites

You must verify all of the following conditions before proceeding:

- Current directory is a git repository
- GitHub CLI (`gh`) is installed and authenticated
- Current branch has commits to compare
- Pull Request is already created

If any condition is not met:

- Stop the process immediately
- Report which condition failed

## Execution Phases

When all conditions are met, execute these phases in order:

### Step 1: Get Branch and Pull Request Information

```bash
current_branch=$(git branch --show-current)
pr_number=$(gh pr list --head "$current_branch" --json number --jq '.[0].number')
```

### Step 2: Determine Base Branch

```bash
base_branch=$(gh pr view "$pr_number" --json baseRefName --jq '.baseRefName')
```

### Step 3: Collect Review Context

```bash
# Get pull request title, body, comments, and reviews in single call
pr_info=$(gh pr view "$pr_number" --json title,body,comments,reviews)
pr_title=$(echo "$pr_info" | jq -r '.title')
pr_body=$(echo "$pr_info" | jq -r '.body')
pr_comments=$(echo "$pr_info" | jq '.comments')
pr_reviews=$(echo "$pr_info" | jq '.reviews')

# Get line-level review comments on diff
pr_line_comments=$(gh api "repos/$repo_owner/$repo_name/pulls/$pr_number/comments")
```

### Step 4: Collect Changes

```bash
changed_files=$(git diff --name-only "${base_branch}...HEAD")
git_diff=$(git diff "${base_branch}...HEAD")
```

### Step 5: Understanding

Make sure the purpose of the pull request and core changes.
You have to organize the information for review or description.
