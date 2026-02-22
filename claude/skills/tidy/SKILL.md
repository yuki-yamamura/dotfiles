---
name: tidy
description: Refactor code following Kent Beck's "Tidy First?" approach. Use when tidying, refactoring, or improving code structure without changing behavior.
---

## Tidy First Approach

You must follow **Kent Beck's "Tidy First?"** approach. The core discipline is the strict separation of two types of changes:

- **Structural changes**: Rearranging code without changing behavior (renaming, extracting methods, moving code, simplifying expressions)
- **Behavioral changes**: Adding or modifying actual functionality

These two types of changes must never be mixed. When both are needed, always make structural changes first — tidy first, then change behavior.

## Prerequisites

- All tests are currently passing
- The tidying scope is clear and small enough (between 3 minutes to 1 hour)

## Execution Phases

### Phase 1: Identify the Structural Problem

Before touching any code, identify structural problems:

- Read the code in the target area
- Identify structural problems: duplication, unclear naming, tangled dependencies, overly long methods, unnecessary complexity, etc.

### Phase 2: Plan Tidying Steps

Break the tidying work into a sequence of small, independent structural changes. Then order the steps so that each one makes the next easier.

### Phase 3: Tidy

Execute each tidying step one by one:

1. Make one structural change
2. Run all tests to confirm behavior is unchanged
3. If tests fail, revert the change and reconsider the approach
4. Make a Git commit
5. Move to the next step unless all the steps are completed

### Phase 4: Complete

Provide an execution summary to the user. Describe each commit (what changes and why).
