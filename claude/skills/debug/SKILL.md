---
name: debug
description: Debug technical issues through comprehensive steps. Use when debugging, troubleshooting, investigating errors, or fixing bugs.
---

## Execution Phases

### Phase 1: Understanding

Make sure what is the problem; you know problem is a gap between expected and actual behavior.

- Use the template as below to make better understanding about the problem. You must fill in the problem details section in this phase
- If there are ambiguous spaces in the context, use the AskUserQuestion tool to make clarification

ref: /Users/yuki/src/github.com/yuki-yamamura/dotfiles/claude/templates/debug-report.md

### Phase 2: Make Hypothesis

1. Determine the relevant scope and divide it into some parts
2. Gather necessary information to make a hypothesis; you have to distinguish between verified findings and speculation
3. Think deeply about what is the root cause and how to solve the problem

Use these tools if necessary:

- Sub-agents for research
- Web Search Tool for external documents and examples
- Chrome DevTools MCP for UI tasks (e.g, handling the console errors, checking the behavior on the browser, etc.)

### Phase 3: Verify Hypothesis

1. Act the verification to see whether the hypothesis is collect or not; ask anything to the user if you can not take care about something (e.g, command executions, authentication, etc.)
2. If the hypothesis is valid as you expected, proceed to the next phase

**Error handling:**

- If there is a gap between the hypothesis and the actual behavior, then back to the phase 1 to consider again
- If another problem happens that is not related to the original one, request a instruction to the user using the AskUserQuestion tool
- If you've already retried more than three times in the same problem, proceed to the phase 5 to give the user report

### Phase 4: Checking

Fill in all the fields on the template. Do not touch the template file directly, you should use volumes in memory or `./tmp` directory.

ref: /Users/yuki/src/github.com/yuki-yamamura/dotfiles/claude/templates/debug-report.md

### Phase 4: Complete

Provide a debug report to the user (format: follow the below template if the debug task has been finished).
