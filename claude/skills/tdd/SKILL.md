---
name: tdd
description: Develop code following Kent Beck's Test-Driven Development (TDD) methodology. Use when implementing features, fixing a bug, and refactoring
---

## Prerequisites

The project has a working test runner and test framework.

## TDD Methodology Guideline

### React/Green/Refactor Cycle

You must follow **Kent Beck's TDD** methodology. The core discipline is the **Red → Green → Refactor** cycle:

- **Red**: Write a small failing test that defines the next increment of desired behavior
- **Green**: Write the minimum code to make the test pass — nothing more
- **Refactor**: Improve structure while keeping all tests green

### Test List

You have a test list that represents necessary test cases to complete the task. So when the task has been finished, all the test cases on the test list are marked as completed.
If you find something new during the TDD cycle, consider it should be added to the test list or not.

## Execution Phases

### Phase 1: Understand the Goal and Steps

Before writing any test, clarify what behavior needs to be added or changed.

- Use the AskUserQuestion tool if the expected behavior is ambiguous
- If the task is not small enough small to test using the Given/When/Then pattern, break it into the smallest testable increments
- Write a test list that represents necessary test cases to achieve the goal using the TodoWrite tool

### Phase 2: Red — Write a Failing Test

Pick one increment on the test list and write failing test:

- Use meaningful test names that describe the expected behavior (e.g., `should return empty list when no items exist`)
- Run the test and confirm it fails for the right reason

### Phase 3: Green — Make Test Pass

Write just enough code to make the failing test pass.

- The simplest solution that could possibly work is the correct one at this stage
- Run all tests and confirm they all pass

### Phase 4: Refactor

With all tests green, consider whether the code can be improved.

- Make one refactoring change at a time
- Both implementation and its test are targets to improve
- Use Martin Fowler's Refactoring methods
- Run all tests to ensure nothing breaks

If no refactoring is needed, skip this phase and move on.

### Phase 5: Judge Repetition

First, you must judge to continue the TDD cycle. If all the test cases has been completed and you think the goal is achieved now, proceed to the final phase; otherwise return to the phase 2 with the next increment.

### Phase 6: Tidy Tests

Once all tests pass and the feature is complete, tidy up the test code itself.

- Remove tests that are no longer needed (e.g., triangulation tests that served their purpose during implementation)
- Check test descriptions and structure so that they are to be self-documenting code
- Order tests by the following sequence: happy path, semi-normal cases, then error cases
