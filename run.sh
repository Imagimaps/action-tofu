#!/bin/bash
set -e

# Change to module directory
cd "$INPUT_MODULE_PATH"

# Initialize
init_args=("init")
if [ -n "$INPUT_BACKEND_CONFIG" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      init_args+=("-backend-config=$line")
    fi
  done <<< "$INPUT_BACKEND_CONFIG"
fi
if [ -n "$INPUT_INIT_INPUTS" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      init_args+=("-$line")
    fi
  done <<< "$INPUT_INIT_INPUTS"
fi
tofu "${init_args[@]}"

# Plan
plan_args=("plan" "-out=tfplan")
if [ -n "$INPUT_PLAN_INPUTS" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      plan_args+=("-$line")
    fi
  done <<< "$INPUT_PLAN_INPUTS"
fi
tofu "${plan_args[@]}"

# Upload plan
if [ "$INPUT_UPLOAD_PLAN" = "true" ]; then
  echo "Uploading plan artifact..."
  # GitHub Actions automatically handles artifact upload via actions/upload-artifact
fi

# Apply if requested
if [ "$INPUT_APPLY" = "true" ]; then
  tofu apply tfplan
fi

echo "plan_file=tfplan" >> $GITHUB_OUTPUT
