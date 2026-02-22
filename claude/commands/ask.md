---
description: Answer the user question (/ask [path_to_context_file])
---

Answer the user question by conducting thorough research and investigation based on a context file.

**IMPORTANT**: Never modify files - only provide answers based on research

## Context File

Refer to $ARGUMENTS. If the user does not provide the path to the context file, use `./tmp/context.md` as the default.

## Prerequisites

You must verify the context file exists before proceeding. If it's missing:

- Stop the process immediately
- Notify the user which condition failed

## Execution Phases

When all conditions are met, parse the context file, then answer the question using the `answer` skill.
