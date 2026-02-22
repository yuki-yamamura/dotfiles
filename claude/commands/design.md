---
description: Create an implementation plan based on a spec file (/design <path_to_spec_file>)
---

Generate a detailed implementation plan that translates requirements into technical design.
This is the second step in Spec Driven Development (SDD) workflow; requirements (what) are already defined, so focus on design decisions and implementation strategy (how).

## Spec File

Refer to $ARGUMENTS. If the spec file path is not provided, use `./tmp/spec.md` as the default.

## Prerequisites

You must verify a context file exists before proceeding. If the context file is missing:

- Stop the process immediately
- Notify the user which condition failed

## Execution Process

When all conditions are met, execute these phases in order:

### Phase 1: Spec Review and

- Read the spec file to understand the goal, requirements, and acceptance criteria
- Consider what information and fact-checking are needed to make technical decisions

## Phase 2: Codebase Research

Research necessary information from codebase:

- Existing conventions, coding guidelines, and implementation examples
- Similar features and architectural patterns

### Phase 3: Web Research

Research necessary information from the web:

- Library and framework documentation relevant to the design
- Best practices for new feature or no existing pattern

### Phase 4: Design

- Think deeply about suitable design in this case
- Make technical decisions per sub-feature to make sure that each acceptance criteria and verification steps are identified

### Phase 5: Planning

Produce an actionable implementation plan (format: follow the below template):

1. **Summary**: What is being built and the high-level approach
2. **Background**: Motivation, context, and reference to the spec file
3. **Design Decisions**: Key technical decisions with rationale and technical findings
4. **Implementation Steps**: Ordered list of changes with target files, what to change, and per-step acceptance criteria
5. **References**: Documentation URLs, codebase references, code snippets, and known gotchas
6. **Acceptance Criteria**: Overall criteria carried forward from the spec with verification steps

ref: /Users/yuki/src/github.com/yuki-yamamura/dotfiles/claude/templates/plan.md

### Phase 4: Complete

Save the implementation plan as `./tmp/plan.md`, then provide the executive summary to the user.
