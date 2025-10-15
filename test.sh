#!/bin/bash
set -e

# Mock tofu command for testing
tofu() {
  echo "tofu $*"
}

# Test 1: Basic init
echo "Test 1: Basic init"
export INPUT_MODULE_PATH="."
export INPUT_BACKEND_CONFIG=""
export INPUT_INIT_VARS=""
export INPUT_PLAN_INPUTS=""
export INPUT_APPLY="false"
export INPUT_UPLOAD_PLAN="false"
export GITHUB_OUTPUT="/tmp/test_output"
echo "" > $GITHUB_OUTPUT

source ./run.sh

# Test 2: Init with backend config
echo -e "\nTest 2: Init with backend config"
export INPUT_BACKEND_CONFIG="bucket=test-bucket
key=test.tfstate"
export INPUT_INIT_VARS="upgrade=true"
export GITHUB_OUTPUT="/tmp/test_output2"
echo "" > $GITHUB_OUTPUT

source ./run.sh

# Test 3: Plan with inputs
echo -e "\nTest 3: Plan with inputs"
export INPUT_BACKEND_CONFIG=""
export INPUT_PLAN_INPUTS="var-file=test.tfvars
var=environment=prod"
export GITHUB_OUTPUT="/tmp/test_output3"
echo "" > $GITHUB_OUTPUT

source ./run.sh

# Test 4: Apply enabled
echo -e "\nTest 4: Apply enabled"
export INPUT_APPLY="true"
export INPUT_DESTROY="false"
export INPUT_PLAN_INPUTS=""
export GITHUB_OUTPUT="/tmp/test_output4"
echo "" > $GITHUB_OUTPUT

source ./run.sh

# Test 5: Destroy enabled
echo -e "\nTest 5: Destroy enabled"
export INPUT_APPLY="false"
export INPUT_DESTROY="true"
export GITHUB_OUTPUT="/tmp/test_output5"
echo "" > $GITHUB_OUTPUT

source ./run.sh

echo -e "\nAll tests completed"
