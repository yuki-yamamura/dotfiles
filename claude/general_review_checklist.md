# General Code Review Checklist

## Self-Check

### Code Cleanliness
- [ ] Remove dead code and commented-out sections
- [ ] Clean up experimental code segments
- [ ] Ensure comments accurately reflect current implementation
- [ ] Remove unused imports and variables
- [ ] Check spelling in variable names, comments, and documentation

### Code Structure & Formatting
- [ ] Consistent indentation and formatting
- [ ] Lines under 120 characters
- [ ] Proper code organization and logical flow
- [ ] Address IDE warnings and suggestions

## Functional Review

### Implementation Quality
- [ ] Code accomplishes the intended purpose
- [ ] Solution is simple and not over-engineered
- [ ] Avoid unnecessary dependencies
- [ ] Proper abstraction level (not too high/low)
- [ ] Functions/methods are reasonably sized (< 40 lines)
- [ ] Classes/modules are manageable (< 200 lines)

### Logic & Control Flow
- [ ] Logic is correct and handles edge cases
- [ ] No potential infinite loops or performance bottlenecks
- [ ] Proper conditional logic without unnecessary complexity
- [ ] Avoid multiple nested if/else blocks where possible

### Error Handling
- [ ] Proper error handling mechanisms in place
- [ ] User-friendly error messages
- [ ] Graceful failure handling
- [ ] Appropriate logging for debugging

## Code Quality

### Readability & Maintainability
- [ ] Code is self-documenting and easy to understand
- [ ] Meaningful variable and function names
- [ ] Names match their actual purpose and context
- [ ] Complex logic is explained with comments (why, not how)
- [ ] Code follows established patterns and conventions

### Code Principles
- [ ] DRY (Don't Repeat Yourself) - no code duplication
- [ ] SOLID principles applied where appropriate
- [ ] Separation of concerns maintained
- [ ] Single responsibility principle followed

### Constants & Configuration
- [ ] Use constants instead of magic numbers/strings
- [ ] Configuration values are externalized
- [ ] Hardcoded values are avoided

## Security & Performance

### Security Considerations
- [ ] Input validation and sanitization
- [ ] No sensitive data exposed in code
- [ ] Proper authentication and authorization
- [ ] No potential security vulnerabilities
- [ ] Secure handling of user data

### Performance
- [ ] No obvious performance bottlenecks
- [ ] Efficient algorithms and data structures
- [ ] Memory usage considerations
- [ ] Database queries optimized (if applicable)

## Testing & Documentation

### Testability
- [ ] Code is testable and modular
- [ ] Dependencies can be mocked/stubbed
- [ ] Pure functions where possible
- [ ] Test coverage for new functionality

### Documentation
- [ ] API documentation updated (if applicable)
- [ ] README or relevant docs updated
- [ ] Breaking changes documented
- [ ] Migration guides provided (if needed)

## Final Checklist

- [ ] All automated tests pass
- [ ] Code builds successfully
- [ ] No linting errors or warnings
- [ ] Performance regression tests pass
- [ ] Security scan results reviewed
- [ ] Code review feedback addressed
- [ ] Documentation is complete and accurate
