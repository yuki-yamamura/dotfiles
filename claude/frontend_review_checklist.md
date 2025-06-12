# Frontend Code Review Checklist

_For TypeScript, React, Next.js Projects_

## TypeScript Specific

### Type Safety

- [ ] Strict TypeScript settings enabled and followed
- [ ] No `any` types used (use proper typing instead)
- [ ] Union types used appropriately for multiple possible values
- [ ] Conditional types used where beneficial
- [ ] Generic types implemented for reusable components
- [ ] `ComponentProps<typeof Component>` used for props inheritance
- [ ] Proper type definitions for external APIs and data

### Modern TypeScript Patterns

- [ ] Proper use of type guards and type assertions
- [ ] Discriminated unions for complex state management
- [ ] Utility types used effectively (Pick, Omit, Partial, etc.)
- [ ] Type-only imports used where appropriate (`import type`)
- [ ] Constants properly typed with `as const` and `satisfies`

  ```typescript
  // ✅ Good - Type-safe constants with proper inference
  export const StatusEnum = {
    PENDING: "pending",
    APPROVED: "approved",
    REJECTED: "rejected",
  } as const satisfies Record<string, Status>;
  export const statusOptions = {
    [StatusEnum.PENDING]: "承認待ち",
    [StatusEnum.APPROVED]: "承認",
    [StatusEnum.REJECTED]: "却下",
  } as const satisfies Record<keyof typeof StatusEnum, string>;

  // ❌ Bad - Missing type safety
  export const StatusEnum = {
    PENDING: "pending",
    APPROVED: "approved",
  };
  ```

## React & Next.js Architecture

### Component Architecture

- [ ] Container/Presenter pattern followed correctly
  - Server Components for data fetching (containers)
  - Client Components for UI logic (presenters)
- [ ] Feature-based structure maintained (`src/features/*/`)
- [ ] Each feature contains proper subdirectories (`actions/`, `components/`, `schemas/`, `types/`, `constants`)
- [ ] Components export from `index.ts`, implementation in separate files

### Component Best Practices

- [ ] Functional components used (no class components)
- [ ] Arrow function components implemented
- [ ] Props type definition follows `type Props =` pattern

  ```typescript
  // ✅ Good - Clear Props type definition
  type Props = {
    id: string;
    onSubmit: (data: FormData) => void;
    disabled?: boolean;
  };

  export const MyComponent = ({ id, onSubmit, disabled = false }: Props) => {
    // ...
  };

  // ❌ Bad - Inline props typing
  export const MyComponent = ({
    id,
    onSubmit,
  }: {
    id: string;
    onSubmit: () => void;
  }) => {
    // ...
  };
  ```

- [ ] Early return pattern for guard clauses

  ```typescript
  // ✅ Good - Early return for clarity
  export const ShopList = ({ shops }: Props) => {
    if (shops.length === 0) {
      return <EmptyState />;
    }

    return (
      <div>
        {shops.map((shop) => (
          <ShopItem key={shop.id} shop={shop} />
        ))}
      </div>
    );
  };
  ```

- [ ] Clear separation between Client and Server Components
- [ ] Proper use of React 19 hooks (`useActionState`, `useTransition`, `useOptimistic`)

### Server Components & Actions

- [ ] Server Actions include proper error handling
- [ ] Server Actions follow `{verb}{target}Action` naming pattern

  ```typescript
  // ✅ Good naming
  export const approveShopAction = async () => {};
  export const deleteItemAction = async () => {};
  export const updateUserProfileAction = async () => {};

  // ❌ Bad naming
  export const shopApprove = async () => {};
  export const handleDelete = async () => {};
  ```

### State Management

- [ ] React 19 hooks used appropriately (`useActionState`, `useTransition`, `useOptimistic`)

  ```typescript
  // ✅ Good - Using useActionState with proper callbacks
  const [lastResult, action] = useActionState(updateShopAction, undefined);

  // ✅ Good - Using useOptimistic for instant feedback
  const [optimisticItems, addOptimisticItem] = useOptimistic(
    items,
    (state, newItem) => [...state, newItem]
  );
  ```

- [ ] Optimistic UI implemented for better UX
- [ ] State updates are properly batched
- [ ] No prop drilling (use context or state management when needed)

## Form Implementation

### Conform + Zod Pattern

- [ ] Conform used with Zod schemas for form validation
- [ ] Schema naming follows `{target}Schema` + `{target}SchemaType` pattern

  ```typescript
  // ✅ Good - Proper schema naming and type export
  export const shopFormSchema = z.object({
    name: z.string().min(1, "Shop name is required"),
    contractType: z.enum(["rental", "wholesale"]),
  });

  export type ShopFormSchemaType = z.infer<typeof shopFormSchema>;

  // ❌ Bad - Inconsistent naming
  export const schema = z.object({...});
  export type ShopData = z.infer<typeof schema>;
  ```

- [ ] `parseWithZod` implemented in onValidate
  ```typescript
  // ✅ Good - Proper Conform + Zod setup
  const [form, fields] = useForm({
    lastResult,
    onValidate({ formData }) {
      return parseWithZod(formData, { schema: shopFormSchema });
    },
  });
  ```
- [ ] Proper form state management with `useForm`

### Form UX

- [ ] Loading states with icons and text
- [ ] Toast notifications for user feedback
- [ ] Proper error message display
- [ ] Form submission disabled during loading
- [ ] Optimistic updates where appropriate

## Styling & UI

### Accessibility & Semantics

- [ ] Semantic HTML used (`<strong>` not `<h3>` for emphasis)
- [ ] Proper heading hierarchy maintained
- [ ] ARIA attributes used where necessary
- [ ] Keyboard navigation support
- [ ] Color contrast meets accessibility standards
- [ ] Screen reader compatibility

### Layout & Grid

- [ ] Proper flexbox and grid implementations
- [ ] Responsive design patterns followed

## Naming Conventions

### File & Component Naming

- [ ] Files use kebab-case (`shop-approve-button.tsx`)
- [ ] Components use PascalCase (`ShopApproveButton`)

  ```typescript
  // File: shop-approve-button.tsx
  export const ShopApproveButton = () => {};

  // File: user-profile-form.tsx
  export const UserProfileForm = () => {};
  ```

- [ ] Functions use camelCase

  ```typescript
  // ✅ Good
  const handleSubmit = () => {};
  const calculateTotalPrice = () => {};
  const validateUserInput = () => {};

  // ❌ Bad
  const handle_submit = () => {};
  const CalculateTotal = () => {};
  ```

- [ ] Descriptive and meaningful names throughout

### Import Organization

- [ ] External libraries → internal libraries → relative paths order
- [ ] Type imports grouped at the end
- [ ] Path conventions followed:

  - Different features: `@/` prefix
  - Sibling/child directories: relative paths (`./`, `../`)

  ```typescript
  // ✅ Good - Proper import organization
  // External libraries
  import { useState, useCallback } from "react";
  import { useRouter } from "next/navigation";

  // Internal libraries from other features
  import { Button } from "@repo/ui";
  import { useAuth } from "@/features/auth/hooks";

  // Relative imports from same feature
  import { ShopCard } from "./shop-card";
  import { formatShopData } from "../utils";

  // Type imports
  import type { Shop } from "@/features/shop/types";
  import type { ComponentProps } from "react";

  // ❌ Bad - Mixed import order
  import type { Shop } from "@/features/shop/types";
  import { ShopCard } from "./shop-card";
  import { useState } from "react";
  import { Button } from "@repo/ui";
  ```

## Performance & Optimization

### Next.js Specific

- [ ] Proper use of Server vs Client components
- [ ] Dynamic imports used for code splitting where beneficial
- [ ] Image optimization with Next.js Image component
- [ ] Proper loading strategies for resources

### React Performance

- [ ] Unnecessary re-renders avoided
- [ ] Memoization used appropriately (`useMemo`, `useCallback`)
- [ ] Keys provided for list items
- [ ] Large lists virtualized if necessary

## API & Data Fetching

### OpenAPI Integration

- [ ] API calls properly typed with generated schemas
- [ ] Backend API integration follows established patterns

### Search Parameters

- [ ] `nuqs` used for type-safe URL parameters

  ```typescript
  // ✅ Good - Type-safe search params with nuqs
  import { parseAsString, parseAsInteger, useQueryStates } from "nuqs";

  const [searchParams, setSearchParams] = useQueryStates({
    search: parseAsString.withDefault(""),
    page: parseAsInteger.withDefault(1),
    status: parseAsString.withDefault("all"),
  });

  // ❌ Bad - Manual URLSearchParams manipulation
  const searchParams = new URLSearchParams(window.location.search);
  const search = searchParams.get("search") || "";
  ```

- [ ] Search state properly synchronized with URL
- [ ] Proper handling of search parameter validation

## Error Handling & UX

### Error States

- [ ] Proper error boundaries implemented
- [ ] Loading states with meaningful indicators
- [ ] Error messages are user-friendly
- [ ] Network error handling implemented
- [ ] Fallback UI for component failures

### User Experience

- [ ] Loading states prevent user confusion
- [ ] Optimistic UI provides immediate feedback
- [ ] Toast notifications used consistently
- [ ] Form validation provides clear feedback

## Testing

### Test Structure

- [ ] Tests use Vitest with Node environment
- [ ] Descriptive test names that explain behavior
- [ ] Test behavior, not implementation details
- [ ] Both general and edge cases covered
- [ ] No complex logic in tests

### Component Testing

- [ ] Components tested in isolation
- [ ] Props and state changes tested
- [ ] User interactions tested
- [ ] Accessibility tested where applicable

## Code Organization & Architecture

### Feature Independence

- [ ] No dependencies between features (enforced by dependency-cruiser)

  ```typescript
  // ✅ Good - Features are independent
  // In shop feature
  import { ShopList } from "./components";
  import { fetchShops } from "./api";

  // In user feature
  import { UserProfile } from "./components";
  import { fetchUser } from "./api";

  // ❌ Bad - Cross-feature dependencies
  // In shop feature
  import { UserAvatar } from "@/features/user/components"; // Violation!
  ```

- [ ] Shared code properly extracted to common areas
  ```typescript
  // ✅ Good - Shared utilities in common location
  import { formatCurrency } from "@/lib/formatters";
  import { Button } from "@repo/ui";
  ```
- [ ] Feature boundaries clearly defined and respected

### Code Comments & Documentation

- [ ] Important implementation reasons prefixed with `// NOTE:`

  ```typescript
  // ✅ Good - NOTE comment explaining important decision
  // NOTE: We disable the form during submission to prevent
  // duplicate requests since the API doesn't handle idempotency
  const isDisabled = form.formState.isSubmitting || isPending;

  // ✅ Good - Temporary solution documented
  // TODO: Remove this workaround once the backend supports
  // batch operations (expected in v2.0)
  const results = await Promise.all(
    items.map((item) => updateItemAction(item.id))
  );
  ```

- [ ] Rationale included for temporary solutions
- [ ] Comments explain "why" not "how"
- [ ] Complex business logic documented

## Git & Development Workflow

### Conventional Commits

- [ ] Commit messages follow Conventional Commits format
- [ ] Commits are atomic and logical
- [ ] Breaking changes properly documented in commits

### Pre-commit Standards

- [ ] Prettier formatting applied
- [ ] ESLint passes with 0 warnings
- [ ] TypeScript compilation succeeds
- [ ] Tests pass for changed files
- [ ] Dependency architecture validation passes

## Final Frontend Checklist

- [ ] Lint passes with no errors
- [ ] TypeScript check passes
- [ ] Teset passes for affected code
- [ ] Build succeeds
- [ ] All React DevTools warnings resolved
- [ ] Component props and state are properly typed
- [ ] No console errors in browser
- [ ] Responsive design tested on multiple screen sizes
