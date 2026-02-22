---
description: Generate a requirements definition document based on a context file (/spec <path_to_context_file>)
---

Generate a comprehensive requirements definition document focused on problem analysis and behavioral specifications.
This is the first step in Spec Driven Development (SDD) workflow, so implementation details are out of scope.

## Context File

Refer to $ARGUMENTS. If the context file path is not provided, use `./tmp/context.md` as the default.

## Prerequisites

You must verify a context file exists before proceeding. If the context file is missing:

- Stop the process immediately
- Notify the user which condition failed

## Execution Process

When all conditions are met, execute these phases in order:

### Phase 1: Problem Analysis

Deeply understand the problem before defining requirements:

- Read the context file thoroughly to understand the high-level request
- Identify the core problem or need being addressed
- Determine target users and their pain points
- Understand the current state and why change is needed
- Clarify what success looks like from a user perspective

### Phase 2: Domain Research

Research domain knowledge and requirements patterns, not implementation details:

- Search for similar features/requirements in the codebase
- Look for existing domain terminology and concepts
- Identify current conventions for similar features
- Research domain knowledge and standard conventions (focus on what, not how)

### Phase 3: Requirements Definition

Define clear, testable requirements (format: follow the below template):

1. **Summary and Background**: Why this is needed, not how it will be built
2. **Scope Boundaries**: Explicit in-scope / out-of-scope to prevent scope creep
3. **Domain Glossary**: Domain-specific terms (remove if unnecessary)
4. **Behavioral Specifications**: Observable behavior per feature using Given/When/Then format
5. **Non-Functional Requirements**: System-wide quality attributes if relevant
6. **Assumptions and Constraints**: Conditions and limitations affecting design
7. **Acceptance Criteria**: Testable, verifiable criteria for completion
8. **Overall Acceptance Criteria**: Link to related documents

ref: /Users/yuki/src/github.com/yuki-yamamura/dotfiles/claude/templates/requirements.md

### Phase 4: Complete

Save the requirements definition document as `./tmp/spec.md`, then provide the executive summary to the user.
