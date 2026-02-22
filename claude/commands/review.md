---
description: AI code review using specialized subagents (/review)
---

Perform comprehensive code review using specialized AI agents working in parallel

**IMPORTANT**: Never modify files - only output review files

## Prerequisites

You must verify the following conditions before proceeding:

- Pull Request exists for the current branch (draft or opened)

If any condition is not met:

- Stop the process immediately
- Notify the user which condition failed

## Specialized Review Agents

The review system employs 8 domain-specific agents:

1. Product Manager: Requirements alignment, acceptance criteria
2. Backend Developer: Server-side architecture, APIs
3. Frontend Developer: UI components, state management, performance, cache strategies
4. UI Engineer: Web standards consistency for UI
5. Infrastructure Engineer: AWS, Terraform
6. Database Engineer: MySQL, PostgreSQL, ORMs
7. Quality Engineer: Testing, reliability, maintainability
8. Refactoring Expert: Code quality, naming conventions, design principles

## Execution Phases

When all conditions are met, execute these phases in order:

### Phase 1: Collect Necessary Information To Review

Use the `pr-diff` skill to understand the purpose of the pull request and what changes are included.

### Phase 2: Select Agents

Analyze the context and changes to determine which specialized subagents to invoke:

1. **Analyze Changed Files and Directories**

- Examine file extensions, paths, and directory structure
- Review git diff content to understand the nature of changes

2. **Determine Required Agents**

Based on the analysis, select relevant subagents:

- Always invoke: pm-reviewer, qa-reviewer, refactoring-reviewer
- Conditionally invoke based on changes:
  - backend-reviewer: When changes in any backend files
  - database-reviewer: When changes in any files relevant DB
  - infrastructure-reviewer: When changes in any files relevant infrastructure
  - frontend-reviewer: When changes any in frontend files
  - ui-reviewer: When changes in any markup or styles

### Phase 3: Parallel Agent Execution

1. **Launch selected subagents in parallel**

Let subagents review for domain-specific areas.

2. **Check execution**

Verify that all the selected subagents are running. If there is any subagent not running, be sure to execute them.

### Phase 4: Result Aggregation

1. **Collect Agent Outputs**
   - Wait for all the selected subagents to complete
   - Gather findings from each output file (e.g. `./tmp/review/pdm-review.md` or `./tmp/review/backend-review.md`)

2. **Categorize Findings**

   Group all findings by severity:
   - ❌ Critical Issues: Must-fix problems
   - ⚠️ Minor Issues: Non-critical improvements
   - ℹ️ Info & Questions: Clarifications needed

3. **Maintain Attribution**
   - Preserve which agent provided each finding
   - Format: `[Agent Name] Finding description (file:line)`

### Phase 5: Generate Unified Report

Create comprehensive review report in `./tmp/review/report.md` (format: follow the below template):

ref: /Users/yuki/src/github.com/yuki-yamamura/dotfiles/claude/templates/review-report.md

### Phase 6: Complete

Provide the executive summary to the user.
