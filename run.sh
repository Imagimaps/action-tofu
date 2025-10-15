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
if [ -n "$INPUT_INIT_VAR_FILES" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      init_args+=("-var-file=$line")
    fi
  done <<< "$INPUT_INIT_VAR_FILES"
fi
if [ -n "$INPUT_INIT_VARS" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      init_args+=("-var=$line")
    fi
  done <<< "$INPUT_INIT_VARS"
fi
echo "Running: tofu ${init_args[*]}"
tofu "${init_args[@]}"

# Plan
plan_args=("plan" "-out=tfplan")
if [ -n "$INPUT_INIT_VAR_FILES" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      plan_args+=("-var-file=$line")
    fi
  done <<< "$INPUT_INIT_VAR_FILES"
fi
if [ -n "$INPUT_INIT_VARS" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      plan_args+=("-var=$line")
    fi
  done <<< "$INPUT_INIT_VARS"
fi
if [ -n "$INPUT_PLAN_VAR_FILES" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      plan_args+=("-var-file=$line")
    fi
  done <<< "$INPUT_PLAN_VAR_FILES"
fi
if [ -n "$INPUT_PLAN_VARS" ]; then
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      plan_args+=("-var=$line")
    fi
  done <<< "$INPUT_PLAN_VARS"
fi
echo "Running: tofu ${plan_args[*]}"
tofu "${plan_args[@]}"

# Upload plan
if [ "$INPUT_UPLOAD_PLAN" = "true" ]; then
  echo "Uploading plan artifact..."
  # GitHub Actions automatically handles artifact upload via actions/upload-artifact
fi

# Apply if requested
if [ "$INPUT_APPLY" = "true" ]; then
  echo "Running: tofu apply tfplan"
  tofu apply tfplan
fi

# Destroy if requested
if [ "$INPUT_DESTROY" = "true" ]; then
  echo "Running: tofu destroy -auto-approve"
  tofu destroy -auto-approve
fi

# Upload plan if requested
if [ "$INPUT_UPLOAD_PLAN" = "true" ]; then
  echo "plan_file=tfplan" >> $GITHUB_OUTPUT
fi

echo "plan_file=tfplan" >> $GITHUB_OUTPUT
