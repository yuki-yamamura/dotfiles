# Go Code Review Checklist

## Self-Check

### Code Cleanliness
- [ ] Remove dead code and commented-out sections
- [ ] Clean up experimental code segments
- [ ] Ensure comments accurately reflect current implementation
- [ ] Remove unused imports and variables
- [ ] Check spelling in variable names, comments, and documentation
- [ ] Run `gofmt` to ensure consistent formatting
- [ ] Run `go vet` and address all warnings
- [ ] Run `golint` or `staticcheck` for additional checks

### Code Structure & Formatting
- [ ] Code follows standard Go formatting (via `gofmt`)
- [ ] Lines under 120 characters
- [ ] Proper code organization and logical flow
- [ ] Package structure follows Go conventions
- [ ] File names use lowercase with underscores (e.g., `http_server.go`)

## Go-Specific Patterns

### Naming Conventions
- [ ] Exported names start with capital letters
- [ ] Unexported names use camelCase
- [ ] Interface names end with `-er` suffix when appropriate (e.g., `Reader`, `Writer`)
- [ ] Package names are short, lowercase, and singular
- [ ] Consistent capitalization for initialisms (e.g., `URL`, `HTTP`, not `Url`, `Http`)
  ```go
  // ✅ Good
  func ServeHTTP(w http.ResponseWriter, r *http.Request) {}
  type APIClient struct {}
  
  // ❌ Bad
  func ServeHttp(w http.ResponseWriter, r *http.Request) {}
  type ApiClient struct {}
  ```

### Variable and Function Names
- [ ] Short, meaningful names for local variables
- [ ] Longer, descriptive names for exported functions and package-level variables
  ```go
  // ✅ Good - Short names in limited scope
  for i, v := range values {
      sum += v
  }
  
  // ✅ Good - Descriptive exported function
  func CalculateMonthlyRevenue(transactions []Transaction) float64 {}
  
  // ❌ Bad - Too verbose for local variable
  for index, currentValue := range values {
      totalSum += currentValue
  }
  ```

## Error Handling

### Error Patterns
- [ ] Always check and handle errors
- [ ] Never ignore errors with `_` unless explicitly justified
- [ ] Return error as the last return value
- [ ] Return `nil` for successful operations
  ```go
  // ✅ Good
  func ProcessData(data []byte) (Result, error) {
      if len(data) == 0 {
          return Result{}, errors.New("empty data")
      }
      return Result{...}, nil
  }
  
  // ❌ Bad
  func ProcessData(data []byte) Result {
      // Ignoring potential errors
      result, _ := parse(data)
      return result
  }
  ```

### Error Messages and Wrapping
- [ ] Error messages start with lowercase
- [ ] Use `errors.Is()` for error comparison
- [ ] Wrap errors with context using `fmt.Errorf` with `%w`
- [ ] Keep error scope small to prevent reuse
  ```go
  // ✅ Good
  if err := db.Connect(); err != nil {
      return fmt.Errorf("failed to connect to database: %w", err)
  }
  
  // ❌ Bad
  if err := db.Connect(); err != nil {
      return errors.New("Database connection failed")  // Loses original error
  }
  ```

## Data Structures and Types

### Slices and Arrays
- [ ] Use `len(slice) == 0` to check if slice is empty (not `slice == nil`)
- [ ] Specify capacity when slice length is known
- [ ] Consider custom types for slices and maps when adding methods
  ```go
  // ✅ Good
  users := make([]User, 0, len(userIDs))
  if len(users) == 0 {
      return ErrNoUsers
  }
  
  // Custom type for collection
  type UserList []User
  func (ul UserList) FindByID(id string) *User { ... }
  ```

### Structs and Methods
- [ ] Move domain logic into struct methods
- [ ] Choose between value and pointer receivers consistently
- [ ] Don't mix receiver types for the same struct
  ```go
  // ✅ Good - Consistent pointer receivers
  type Account struct {
      balance float64
  }
  
  func (a *Account) Deposit(amount float64) error { ... }
  func (a *Account) Withdraw(amount float64) error { ... }
  func (a *Account) Balance() float64 { ... }
  ```

### Interfaces
- [ ] Define interfaces in the consuming package
- [ ] Return concrete types, not interfaces
- [ ] Keep interfaces small and focused
- [ ] Don't create interfaces before they're needed
  ```go
  // ✅ Good - Interface defined where used
  package consumer
  
  type DataStore interface {
      Get(key string) ([]byte, error)
  }
  
  // ❌ Bad - Premature interface in provider package
  package provider
  
  type Store interface {
      Get(key string) ([]byte, error)
      Set(key string, value []byte) error
      Delete(key string) error
      // ... many more methods
  }
  ```

## Functions and Control Flow

### Function Design
- [ ] Prefer synchronous functions over asynchronous
- [ ] Use context as first parameter when needed
- [ ] Use named return values for multiple same-type returns
- [ ] Directly return function results when possible
  ```go
  // ✅ Good - Named returns for clarity
  func ParseCoordinates(input string) (lat, lng float64, err error) {
      // ...
  }
  
  // ✅ Good - Direct return
  func GetUser(id string) (*User, error) {
      return db.FindUser(id)
  }
  ```

### Control Flow
- [ ] Use early returns to reduce nesting
- [ ] Avoid deep conditional nesting
- [ ] Handle error cases first
  ```go
  // ✅ Good - Early returns
  func ProcessRequest(req *Request) error {
      if req == nil {
          return ErrNilRequest
      }
      if !req.IsValid() {
          return ErrInvalidRequest
      }
      
      // Main logic here
      return nil
  }
  
  // ❌ Bad - Deep nesting
  func ProcessRequest(req *Request) error {
      if req != nil {
          if req.IsValid() {
              // Main logic here
              return nil
          } else {
              return ErrInvalidRequest
          }
      } else {
          return ErrNilRequest
      }
  }
  ```

## Concurrency

### Goroutines
- [ ] Be explicit about goroutine lifetimes
- [ ] Avoid goroutine leaks
- [ ] Use sync.WaitGroup or channels for synchronization
- [ ] Don't start goroutines in init()
  ```go
  // ✅ Good - Controlled goroutine
  func ProcessItems(items []Item) error {
      var wg sync.WaitGroup
      errCh := make(chan error, len(items))
      
      for _, item := range items {
          wg.Add(1)
          go func(it Item) {
              defer wg.Done()
              if err := process(it); err != nil {
                  errCh <- err
              }
          }(item)
      }
      
      wg.Wait()
      close(errCh)
      
      // Check for errors
      for err := range errCh {
          if err != nil {
              return err
          }
      }
      return nil
  }
  ```

### Context Usage
- [ ] Don't store Context in structs
- [ ] Pass Context as first parameter
- [ ] Respect context cancellation
  ```go
  // ✅ Good
  func FetchData(ctx context.Context, id string) (*Data, error) {
      select {
      case <-ctx.Done():
          return nil, ctx.Err()
      default:
          // Fetch logic
      }
  }
  
  // ❌ Bad
  type Service struct {
      ctx context.Context  // Don't store context
  }
  ```

## Testing

### Test Structure
- [ ] Use table-driven tests for multiple scenarios
- [ ] Write clear, informative test names
- [ ] Ensure tests provide meaningful failure messages
- [ ] Use `t.Helper()` for test helper functions
  ```go
  // ✅ Good - Table-driven test
  func TestCalculateDiscount(t *testing.T) {
      tests := []struct {
          name     string
          price    float64
          discount float64
          want     float64
      }{
          {"no discount", 100, 0, 100},
          {"10% discount", 100, 0.1, 90},
          {"50% discount", 100, 0.5, 50},
      }
      
      for _, tt := range tests {
          t.Run(tt.name, func(t *testing.T) {
              got := CalculateDiscount(tt.price, tt.discount)
              if got != tt.want {
                  t.Errorf("CalculateDiscount(%v, %v) = %v, want %v",
                      tt.price, tt.discount, got, tt.want)
              }
          })
      }
  }
  ```

### Test Assertions
- [ ] Use appropriate assertion methods
- [ ] Understand difference between `t.Fatal` and `t.Error`
- [ ] Check both positive and negative cases
- [ ] Test edge cases and error conditions

## Performance and Security

### Memory and Performance
- [ ] Avoid unnecessary pointer usage
- [ ] Be mindful of slice/struct copying
- [ ] Preallocate slices when size is known
- [ ] Use `strings.Builder` for string concatenation
  ```go
  // ✅ Good - Preallocated slice
  results := make([]Result, 0, len(inputs))
  
  // ✅ Good - strings.Builder
  var sb strings.Builder
  for _, s := range strings {
      sb.WriteString(s)
  }
  result := sb.String()
  ```

### Security
- [ ] Use `crypto/rand` for cryptographic operations
- [ ] Never use `math/rand` for security purposes
- [ ] Validate all inputs
- [ ] Use `time.Duration` for time operations
  ```go
  // ✅ Good
  timeout := 5 * time.Second
  
  // ❌ Bad
  timeout := 5000  // Unclear unit
  ```

## Documentation

### Comments
- [ ] Package comments start with "Package <name>"
- [ ] Exported functions have comments starting with function name
- [ ] Comments are complete sentences with proper punctuation
- [ ] Comments explain "why" not "what"
  ```go
  // Package auth provides authentication middleware and utilities
  // for the application.
  package auth
  
  // ValidateToken checks if the provided JWT token is valid and
  // returns the associated user claims.
  func ValidateToken(token string) (*Claims, error) {
      // Implementation
  }
  ```

## Enterprise Patterns

### Clean Architecture/DDD
- [ ] Domain models are pure and contain no external dependencies
- [ ] Use case interfaces clearly separate commands from queries
- [ ] Repository interfaces are defined in domain layer, not infrastructure
- [ ] Dependency injection flows inward (domain <- usecase <- infrastructure)
  ```go
  // ✅ Good - Domain interface, infrastructure implementation
  package domain
  type UserRepository interface {
      FindByID(ctx context.Context, id uint64) (*User, error)
  }
  
  package infrastructure
  type UserRepo struct { db *gorm.DB }
  func (r *UserRepo) FindByID(ctx context.Context, id uint64) (*User, error) { ... }
  ```

### Error Handling Patterns
- [ ] Use structured error types with error codes for application errors
- [ ] Wrap errors with context while preserving original error
- [ ] Define domain-specific sentinel errors
- [ ] Use `errors.Is()` for error comparison, not string matching
  ```go
  // ✅ Good - Structured error handling
  type AppError struct {
      Code    ErrorCode
      Message string
      Err     error
  }
  
  func (e *AppError) Error() string { return e.Err.Error() }
  func (e *AppError) Wrap(err error, msg string) *AppError { ... }
  
  // Domain errors
  var ErrUserNotFound = errors.New("user not found")
  
  // Usage
  if errors.Is(err, ErrUserNotFound) {
      return apperror.NAData.Wrap(err, "failed to get user")
  }
  ```

### Code Generation
- [ ] Generated code is excluded from manual review
- [ ] Code generation is part of the build pipeline
- [ ] Generated files have proper build tags or header comments
- [ ] Source files for generation (OpenAPI, SQL schema) are version controlled
  ```go
  // ✅ Good - Generated file header
  // Code generated by oapi-codegen. DO NOT EDIT.
  
  //go:generate go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen --config=codegen.yaml openapi.yaml
  ```

## Advanced Testing

### Test Structure and Mocking
- [ ] Use dependency injection to enable easy mocking
- [ ] Mock external dependencies at interface boundaries
- [ ] Test both success and failure scenarios comprehensively
- [ ] Use `testify/mock` for behavior verification, not just return values
  ```go
  // ✅ Good - Comprehensive test with mocks
  func TestUserService_CreateUser(t *testing.T) {
      tests := []struct {
          name        string
          input       *CreateUserInput
          setupMocks  func(*MockUserRepo, *MockEmailService)
          wantErr     error
      }{
          {
              name: "success case",
              setupMocks: func(repo *MockUserRepo, email *MockEmailService) {
                  repo.On("Create", mock.Anything, mock.AnythingOfType("*User")).Return(nil)
                  email.On("SendWelcome", mock.Anything, mock.AnythingOfType("string")).Return(nil)
              },
          },
          {
              name: "database error",
              setupMocks: func(repo *MockUserRepo, email *MockEmailService) {
                  repo.On("Create", mock.Anything, mock.AnythingOfType("*User")).Return(ErrDatabaseConnection)
              },
              wantErr: ErrDatabaseConnection,
          },
      }
      // ... test execution
  }
  ```

### Integration Testing
- [ ] Use testcontainers for database integration tests
- [ ] Test complete request/response cycles for handlers
- [ ] Verify external service integration with proper mocking
- [ ] Test configuration loading and environment setup

## Production Readiness

### Configuration Management
- [ ] Never hardcode credentials or sensitive configuration
- [ ] Use environment variables or secure configuration management
- [ ] Validate configuration at startup
- [ ] Provide sensible defaults where appropriate
  ```go
  // ✅ Good - Configuration validation
  type Config struct {
      DatabaseURL string `env:"DATABASE_URL,required"`
      JWTSecret   string `env:"JWT_SECRET,required"`
      Port        int    `env:"PORT" envDefault:"8080"`
  }
  
  func (c *Config) Validate() error {
      if c.DatabaseURL == "" {
          return errors.New("DATABASE_URL is required")
      }
      return nil
  }
  
  // ❌ Bad - Hardcoded credentials
  func BasicAuth(username, password string, c echo.Context) (bool, error) {
      if username == "admin" && password == "admin" { // Never do this
          return true, nil
      }
      return false, nil
  }
  ```

### Dependency Management
- [ ] Pin dependencies to specific versions in go.mod
- [ ] Regularly update dependencies and test for compatibility
- [ ] Use `go mod vendor` if vendoring dependencies
- [ ] Document any version constraints or compatibility requirements

### Build and Deployment
- [ ] Use multi-stage Docker builds for smaller images
- [ ] Include health check endpoints for load balancers
- [ ] Implement graceful shutdown handling
- [ ] Use build tags for environment-specific code
  ```go
  // ✅ Good - Graceful shutdown
  func (s *Server) Shutdown(ctx context.Context) error {
      s.echo.Logger.Info("Shutting down server...")
      return s.echo.Shutdown(ctx)
  }
  
  // Health check endpoint
  func (h *HealthHandler) Check(c echo.Context) error {
      return c.JSON(http.StatusOK, map[string]string{"status": "ok"})
  }
  ```

## Domain-Specific Patterns

### Constructor Functions
- [ ] Use constructor functions for complex domain objects
- [ ] Validate inputs in constructors
- [ ] Return pointers for structs that have methods
- [ ] Keep constructors focused on object creation, not business logic
  ```go
  // ✅ Good - Constructor with validation
  func NewUser(email, firstName, lastName string) (*User, error) {
      if email == "" {
          return nil, errors.New("email is required")
      }
      if !isValidEmail(email) {
          return nil, errors.New("invalid email format")
      }
      
      return &User{
          ID:        generateID(),
          Email:     email,
          FirstName: firstName,
          LastName:  lastName,
          CreatedAt: time.Now(),
      }, nil
  }
  ```

### Repository Pattern
- [ ] Define repository interfaces in domain layer
- [ ] Implement repositories in infrastructure layer
- [ ] Use context for cancellation and timeouts
- [ ] Return domain models, not database models
  ```go
  // ✅ Good - Repository interface in domain
  package domain
  
  type UserRepository interface {
      FindByID(ctx context.Context, id uint64) (*User, error)
      Create(ctx context.Context, user *User) error
      Update(ctx context.Context, user *User) error
  }
  
  // Implementation in infrastructure
  package infrastructure
  
  type UserRepo struct { q *query.Query }
  
  func (r *UserRepo) FindByID(ctx context.Context, id uint64) (*domain.User, error) {
      // Database query
      dbUser, err := r.q.User.WithContext(ctx).Where(user.ID.Eq(id)).First()
      if err != nil {
          if errors.Is(err, gorm.ErrRecordNotFound) {
              return nil, domain.ErrUserNotFound
          }
          return nil, err
      }
      
      // Convert to domain model
      return domain.NewUser(dbUser.Email, dbUser.FirstName, dbUser.LastName)
  }
  ```

## Final Checklist

- [ ] All tests pass (`go test ./...`)
- [ ] Code builds successfully (`go build`)
- [ ] No race conditions (`go test -race ./...`)
- [ ] No linting errors (`golangci-lint run`)
- [ ] Dependencies are vendored or go.mod is updated
- [ ] Breaking changes are documented
- [ ] Performance benchmarks pass (if applicable)
- [ ] Security scan results reviewed
- [ ] Code coverage is maintained or improved
- [ ] Configuration validation passes at startup
- [ ] No hardcoded credentials or sensitive data
- [ ] Integration tests pass with real dependencies