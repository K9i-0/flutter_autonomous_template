#!/bin/bash
# Stop hook: Run analyze and tests before completing tasks

cd "$CLAUDE_PROJECT_DIR" || exit 0

# 1. Run dart analyze
ANALYZE_RESULT=$(dart analyze lib/ 2>&1)
ANALYZE_ERRORS=$(echo "$ANALYZE_RESULT" | grep -c "error -")

if [ "$ANALYZE_ERRORS" -gt 0 ]; then
  # exit 2 + stderr to notify Claude of errors
  echo "dart analyze found $ANALYZE_ERRORS error(s). Please fix before completing:" >&2
  echo "$ANALYZE_RESULT" | grep "error -" | head -5 >&2
  exit 2
fi

# 2. Run tests (only if Dart files in lib/ have changed)
CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null | grep "^lib/.*\.dart$" | wc -l)

if [ "$CHANGED_FILES" -gt 0 ]; then
  TEST_RESULT=$(flutter test --no-pub 2>&1)
  TEST_EXIT=$?

  if [ $TEST_EXIT -ne 0 ]; then
    echo "Tests failed. Please fix before completing:" >&2
    echo "$TEST_RESULT" | tail -20 >&2
    exit 2
  fi
fi

echo "All checks passed (analyze: OK, tests: OK)"
exit 0
