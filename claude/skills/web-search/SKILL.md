---
name: web-search
description: Retrieve external information from the web. Use when external documentation or information is needed.
---

## Retrieval Criteria

Establish these before searching. They guide which sources to pursue and accept.

- **Version alignment**: match the library versions used in the project
- **Credibility**: official docs > community sources (Stack Overflow, Medium, and popular blog posts)
- **Freshness**: check for deprecation notices and version-specific changes

Skip or deprioritize sources that don't meet these criteria.

## Execution Phases

### Phase 1: Understanding

- Identify what information is needed and why
- Check the project for relevant context (package versions, existing docs, config files)
- Determine whether the query is about a specific library/API or a general topic

### Phase 2: Retrieval

Retrieve information using the following priority order, applying the retrieval criteria to select and filter sources during retrieval.

1. **MPC Tools** - If a project specific MCP tool (e.g, `aws-documentation-mcp-server`) is configured and suitable, use it at first.
2. **Context7 MCP** — If the query is about a library or API, attempt Context7 MCP. Resolve the library name, then fetch documentation. Skip if the library is not available on Context7 MCP.
3. **Web Search** — Search the web. Check if the relevant site provides an `llms.txt` (e.g., `https://<domain>/llms.txt`). If available, fetch it with the WebFetch tool for a more structured source. If not, use the search results directly.

### Phase 3: Complete

Present findings with source URLs.
