# React

## Basic Structure

Components follow these rules:

```typescript
// 1. "use client" directive (for client components)
"use client";

// 2. Internal imports
import { SubComponent } from "./sub-component";

// 3. External library imports
import { useState } from "react";

// 4. Type imports
import type { SomeType } from "@/path/to/types";

// 5. Style imports
import styles from "./index.module.css";

// 6. Props type definition
type Props = {
  prop1: string;
  prop2?: number;
};

// 7. Component implementation (exported as named export)
export const ComponentName = ({ prop1, prop2 }: Props) => {
  // Logic

  // JSX
  return <div className={styles.base}>{/* Content */}</div>;
};
```

- Use early returns when possible instead of conditional rendering in JSX
- Keep JSX as pure markup as much as possible

## Directory Structure

Each component is placed in its own directory and includes the following files:

```
component-name/
├── index.tsx             # Component implementation
├── index.module.css      # Component-specific styles
├── index.stories.ts      # Storybook stories (if needed)
├── use-get-todo.ts       # Hooks used only by this component
└── index.test.ts         # Tests (if needed)
```

## Separation

- Prioritize server components whenever possible
- Components export only a single component, except when adopting the composition pattern
- When file size becomes large, create child component directories under the parent component directory as needed

## Type Imports

Use the `import type` syntax for type imports:

```typescript
import type { ComponentPropsWithChildren } from "react";

import type { SomeType } from "@/app/(models)/types/some-type";
```

## CSS Conventions

### Using CSS Modules

All styles are implemented as CSS modules using the `.module.css` extension:

```css
.base {
  display: flex;
  flex-direction: column;
  row-gap: 24px;
}

.link {
  padding-inline: 12px;

  &:hover {
    background-color: #f7f2f0;
  }
}
```

### CSS Class Naming Conventions

- Use `.base` class name for the base element
- Use semantic names for elements within components (`.header`, `.content`, `.icon`, etc.)
- For state-representing class names, use the format of target + state (`.linkActive`, `.buttonDisabled`, etc.)

### Applying Styles

```typescript
import styles from "./index.module.css";

export const Component = () => (
  <div className={styles.base}>
    <span className={styles.label}>Label</span>
  </div>
);
```

## Variants

- Use Class Variance Authority for component variants
- Use the `cx` utility when combining multiple classes

```typescript
import { cx } from "class-variance-authority";

<div className={cx(styles.base, someCondition && styles.active)}>
```

