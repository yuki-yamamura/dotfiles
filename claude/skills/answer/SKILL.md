---
name: answer
description: Answer questions with through research and investigation. Use when you asked a question from the user.
---

## Execution Phases

### Phase 1. Understanding

- Check the question from the context provided by the user
- Extract file references if provided (e.g., `src/components/button.tsx:42`)
- Understand what the user would like to make sure

### Phase 2. Clarification

If the user question is ambiguous, use the AskUserQuestion tool to make clarification.

### Phase 3. Research & Analysis

You have to find evidence to provide correct information to the user.

- Search for existing patterns, guidelines, or fact-checking from the codebase.
- Search for documents in other repositories.
- Search for best practices and solutions from the web.

When evidence is found, verify whether it is accurate before drawing conclusions.
If you find mistakes or uncertainties, you should go back to the understanding phase again.

Use these tools if necessary:

- Sub-agents for research
- Web search Tool for external documents and examples
- Chrome DevTools MCP for UI tasks (e.g, handling the console errors, checking the behavior on the browser, etc.)

### Phase 4. Complete

Answer the question (format: follow the below template).

ref: ref: /Users/yuki/src/github.com/yuki-yamamura/dotfiles/claude/templates/answer-report.md

- Reference specific files and line numbers when relevant files exist (format: `<file_path>:<line_number>`)
- Include supporting URLs you've found.
- Include code snippets or examples to describe when helpful
