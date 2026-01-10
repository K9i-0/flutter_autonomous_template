#!/bin/bash
# PostToolUse hook: Run analyze after editing Dart files

# Read JSON from stdin
INPUT=$(cat)

# Extract file_path from tool_input
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Skip if not a Dart file
if [[ ! "$FILE_PATH" =~ \.dart$ ]]; then
  exit 0
fi

# Skip test files (frequent edits)
if [[ "$FILE_PATH" =~ /test/ ]]; then
  exit 0
fi

# Move to project root
cd "$CLAUDE_PROJECT_DIR" || exit 0

# Analyze only the edited file
RESULT=$(dart analyze "$FILE_PATH" 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  # Notify Claude of errors
  echo "Analyze errors in $FILE_PATH:"
  echo "$RESULT" | grep -E "error|warning" | head -10
  exit 0  # exit 0 to display stdout to Claude
fi

exit 0
