# TypeScript

## Naming Conventions

Follow these naming conventions for both frontend and backend:

- Directory names: kebab-case
- File names: kebab-case
- Component names: PascalCase
- Type names: PascalCase

## Modules

- Use Named exports unless restricted by libraries or frameworks
- Write `export` at the beginning of the target function or constant
- Relative path imports are only allowed within the same module

```typescript
// OK
import { Foo } from "./foo";

// NG
import { Bar } from "../bar";
```

## Function Definitions

- Use Arrow Functions in all cases

## Testing Conventions

### Test File Placement

Test files should be placed in the same directory as the target file, using `.test.ts` or `.test.tsx` extensions.

### Test Structure

- Adopt the 3A pattern (Arrange, Act, Assert)
- Mock data
  - Create within the same file as the test
  - Create factory functions as needed

