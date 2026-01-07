# Testing Documentation

## Overview

This document provides comprehensive information about the test suite for DelYo, a Flutter mobile application for tracking padel matches. The test suite focuses on unit and logic tests, ensuring the reliability of core business functionality.

## Test Philosophy

### Principles
- **Unit Testing Focus**: Emphasis on testing business logic and data models
- **No UI Testing**: Widget and visual tests are excluded from current scope
- **Clear Test Names**: Descriptive test names that explain the expected behavior
- **Small, Focused Tests**: Each test validates a specific piece of functionality
- **Edge Case Coverage**: Comprehensive testing of boundary conditions and error scenarios

### Testing Standards
- English language only
- Flutter testing best practices
- Proper setup and teardown procedures
- Isolated test cases with no dependencies between tests
- Clear separation of test concerns

## Test Structure

```
test/
├── domain/                          # Domain layer tests
│   ├── models/                      # Entity and value object tests
│   │   ├── match_test.dart         # Match model tests
│   │   ├── match_result_test.dart  # Match result tests
│   │   ├── padel_set_test.dart     # Set scoring tests
│   │   └── player_test.dart        # Player entity tests
│   └── enums/                       # Enumeration tests
│       ├── match_type_test.dart    # Match type enum tests
│       ├── playing_side_test.dart  # Playing side enum tests
│       └── time_range_test.dart    # Time filtering enum tests
├── features/                        # Feature-specific tests
│   ├── shared/                      # Shared functionality tests
│   │   └── state/
│   │       └── filtered_matches_provider_test.dart
│   ├── matches/                     # Match management tests
│   │   └── presentation/
│   │       └── utils/
│   │           └── match_outcome_helper_test.dart
│   └── stats/                       # Statistics tests
│       └── utils/
│           └── statistics_calculator_test.dart
├── data/                            # Data layer tests
│   └── repositories/
│       └── match_repository_hive_test.dart
└── widget_test.dart                 # Reserved for future widget tests
```

## Test Categories

### Domain Layer Tests

#### Match Model Tests (`test/domain/models/match_test.dart`)
**Purpose**: Validate the core Match entity functionality

**Coverage**:
- Match creation with required fields
- Match creation with optional fields (duration, location, performance rating, notes)
- All match types (Friendly, League, Tournament)
- Both playing sides (Left, Right)
- Equality and hash code implementation
- String representation
- Performance rating validation (1-5 scale)
- Field difference detection in equality checks

**Key Test Cases**:
```dart
// Basic creation
test('should create a match with required fields')

// Optional fields
test('should create a match with optional fields')

// Equality testing
test('should be equal when all fields match')
test('should not be equal when duration differs')
test('should not be equal when location differs')

// Enum support
test('should support all match types')
test('should support both playing sides')
```

#### Match Result Tests (`test/domain/models/match_result_test.dart`)
**Purpose**: Validate match outcome calculation logic

**Coverage**:
- Win/loss determination based on sets won
- Sets won/lost counting
- Empty sets handling
- Single set matches
- Tied sets scenarios
- Equality and string representation

#### Padel Set Tests (`test/domain/models/padel_set_test.dart`)
**Purpose**: Validate individual set scoring

**Coverage**:
- Set creation with game scores
- Win determination (user team vs opponent team)
- Tied scores handling
- Zero scores handling
- Tiebreak scores (7-6, etc.)
- Equality and string representation

#### Player Tests (`test/domain/models/player_test.dart`)
**Purpose**: Validate player entity functionality

**Coverage**:
- Player creation with required fields (id, name)
- Optional nickname handling
- Equality comparison
- String representation
- Null nickname scenarios

### Enumeration Tests

#### Match Type Tests (`test/domain/enums/match_type_test.dart`)
**Purpose**: Validate MatchType enum functionality

**Coverage**:
- All enum values (friendly, league, tournament)
- Consistent ordering
- String representation
- Equality comparison
- Switch statement compatibility
- Name and index properties

#### Playing Side Tests (`test/domain/enums/playing_side_test.dart`)
**Purpose**: Validate PlayingSide enum functionality

**Coverage**:
- Both enum values (right, left)
- Consistent ordering
- String representation
- Equality comparison
- Switch statement compatibility
- Opposite side logic utility

#### Time Range Tests (`test/domain/enums/time_range_test.dart`)
**Purpose**: Validate TimeRange enum for filtering functionality

**Coverage**:
- All time range values (lastMonth, lastThreeMonths, lastYear, allTime)
- Display name generation
- Start date calculation for each range
- Null start date for allTime
- Month overflow handling (e.g., January - 1 month = December previous year)
- Consistent enum ordering

**Key Features Tested**:
```dart
// Display names
expect(TimeRange.lastMonth.displayName, equals('Last Month'))

// Start date calculation
final startDate = TimeRange.lastMonth.startDate
expect(startDate, isNotNull)

// All time returns null (no filtering)
expect(TimeRange.allTime.startDate, isNull)
```

### Feature Tests

#### Filtered Matches Provider Tests (`test/features/shared/state/filtered_matches_provider_test.dart`)
**Purpose**: Validate date-based match filtering logic

**Coverage**:
- All time range filtering (lastMonth, lastThreeMonths, lastYear, allTime)
- Empty match list handling
- Boundary date scenarios
- Match ordering preservation
- Edge cases (all matches outside filter range)
- Exact boundary date handling (isAfter logic)

**Test Data Setup**:
- Matches from different time periods (2 weeks, 2 months, 6 months, 2 years ago)
- Various match types and outcomes
- Realistic date scenarios

#### Match Outcome Helper Tests (`test/features/matches/presentation/utils/match_outcome_helper_test.dart`)
**Purpose**: Validate match outcome determination and result text formatting

**Coverage**:
- Win/loss/draw determination for friendly matches
- Win/loss only for official matches (league/tournament)
- Result text formatting with set scores
- Different match types behavior
- Edge cases (tied sets in official matches)

**Business Rules Tested**:
- Friendly matches can end in draws (tied sets)
- Official matches always have winners (no draws)
- Result text includes set scores (e.g., "Win (2-1)", "Draw (1-1)")

#### Statistics Calculator Tests (`test/features/stats/utils/statistics_calculator_test.dart`)
**Purpose**: Validate statistical calculations for match analysis

**Coverage**:
- Win rate calculation (percentage)
- Match type distribution counting
- Outcome distribution (wins/losses/draws)
- Average performance rating calculation
- Playing side preference analysis
- Win rates by match type
- Recent form tracking (last N matches)

**Statistical Functions**:
```dart
// Win rate calculation
static double calculateWinRate(List<Match> matches)

// Distribution calculations
static Map<MatchType, int> calculateMatchTypeDistribution(List<Match> matches)
static Map<MatchOutcome, int> calculateOutcomeDistribution(List<Match> matches)

// Performance metrics
static double calculateAveragePerformanceRating(List<Match> matches)
static List<MatchOutcome> calculateRecentForm(List<Match> matches, int count)
```

### Data Layer Tests

#### Match Repository Hive Tests (`test/data/repositories/match_repository_hive_test.dart`)
**Purpose**: Validate local data persistence using Hive database

**Coverage**:
- Match saving and retrieval
- Match updating (overwrite existing)
- Match deletion
- Bulk operations (get all matches, clear all)
- Data sorting (newest first)
- Concurrent operations
- Data persistence across repository instances
- All match fields preservation
- Player information preservation
- Match result with multiple sets

**Setup and Teardown**:
- Temporary Hive directory creation
- Adapter registration
- Box opening and closing
- Cleanup after each test

## Test Data Patterns

### Common Test Data
```dart
// Standard test players
const testPlayer1 = Player(id: '1', name: 'Partner');
const testPlayer2 = Player(id: '2', name: 'Opponent 1');
const testPlayer3 = Player(id: '3', name: 'Opponent 2');

// Standard test result
const testResult = MatchResult(
  sets: [PadelSet(userTeamGames: 6, opponentTeamGames: 4)],
);

// Standard test date
final testDateTime = DateTime(2025, 1, 15, 10, 0);
```

### Test Match Creation Helper
```dart
Match createTestMatch({
  String id = 'match1',
  MatchType matchType = MatchType.friendly,
  DateTime? dateTime,
  PlayingSide playingSide = PlayingSide.right,
  int? performanceRating,
  String? notes,
}) {
  return Match(
    id: id,
    matchType: matchType,
    dateTime: dateTime ?? DateTime(2025, 1, 15, 10, 0),
    playingSide: playingSide,
    partner: testPlayer1,
    opponent1: testPlayer2,
    opponent2: testPlayer3,
    result: testResult,
    performanceRating: performanceRating,
    notes: notes,
  );
}
```

## Running Tests

### Command Line
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/domain/models/match_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests in a specific directory
flutter test test/domain/
```

### IDE Integration
- Tests can be run individually or in groups from VS Code or Android Studio
- Test results show pass/fail status with detailed error messages
- Debugging support for test failures

## Test Maintenance

### Adding New Tests
1. **Identify the layer**: Determine if the test belongs in domain, features, or data layer
2. **Follow naming conventions**: Use descriptive test names that explain expected behavior
3. **Use proper setup**: Include necessary test data setup and cleanup
4. **Test edge cases**: Include boundary conditions and error scenarios
5. **Keep tests isolated**: Ensure tests don't depend on each other

### Updating Existing Tests
1. **Review test relevance**: Ensure tests still match current business logic
2. **Update test data**: Modify test data to match new model fields or requirements
3. **Maintain coverage**: Ensure new features or changes are properly tested
4. **Refactor when needed**: Improve test clarity and maintainability

### Test Quality Checklist
- [ ] Test name clearly describes expected behavior
- [ ] Test is focused on a single piece of functionality
- [ ] Edge cases and error conditions are covered
- [ ] Test data is realistic and representative
- [ ] Setup and teardown are properly handled
- [ ] No dependencies between tests
- [ ] Assertions are clear and specific

## Coverage Areas

### ✅ Fully Covered
- **Domain Models**: Match, MatchResult, PadelSet, Player
- **Domain Enums**: MatchType, PlayingSide, TimeRange
- **Filtering Logic**: Date-based match filtering for all time ranges
- **Statistics**: Win rates, distributions, performance metrics
- **Match Outcomes**: Win/loss/draw determination and formatting
- **Data Persistence**: Hive repository operations

### 🔄 Partially Covered
- **Widget Tests**: Placeholder exists, no current implementation
- **Integration Tests**: Not in current scope

### ❌ Not Covered (By Design)
- **UI/Widget Testing**: Excluded from current scope
- **Golden Tests**: Excluded from current scope
- **End-to-End Tests**: Not in current scope

## Future Test Considerations

### Potential Additions
- **Widget Tests**: When UI testing becomes necessary
- **Integration Tests**: For testing feature interactions
- **Performance Tests**: For large dataset scenarios
- **Accessibility Tests**: For inclusive design validation

### Maintenance Schedule
- **Regular Review**: Monthly review of test relevance and coverage
- **Update on Changes**: Update tests when business logic changes
- **Refactoring**: Quarterly refactoring for test maintainability
- **Coverage Analysis**: Regular coverage reports to identify gaps

## Troubleshooting

### Common Issues
1. **Hive Adapter Registration**: Ensure adapters are registered before running repository tests
2. **Date Dependencies**: Use fixed dates in tests to avoid time-dependent failures
3. **Async Operations**: Properly await async operations in repository tests
4. **Test Isolation**: Ensure proper cleanup between tests

### Debug Tips
- Use `debugPrint()` for test debugging
- Run individual tests to isolate failures
- Check test setup and teardown methods
- Verify test data matches expected format

This documentation serves as a comprehensive guide for understanding, maintaining, and extending the DelYo test suite.
