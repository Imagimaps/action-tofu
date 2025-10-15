# Action Tofu

## Description

A GitHub Action to plan and apply OpenTofu modules with configurable backend and input parameters.

## Usage

```yaml
- uses: Imagimaps/action-tofu@v1
  with:
    tofu_version: 'latest'
    module_path: './infrastructure'
    backend_config: |
      bucket=my-bucket
      key=terraform.tfstate
    init_inputs: |
      upgrade=true
    plan_inputs: |
      var-file=prod.tfvars
    apply: false
    upload_plan: true
```

## Inputs

- `tofu_version`: OpenTofu version to use (default: 'latest')
- `module_path`: Path to the OpenTofu module (required)
- `backend_config`: Backend configuration as multiline key=value pairs
- `init_inputs`: Init inputs as multiline key=value pairs  
- `plan_inputs`: Plan inputs as multiline key=value pairs
- `apply`: Whether to apply the plan (default: false)
- `upload_plan`: Upload plan file to GitHub artifacts (default: true)

## Outputs

- `plan_file`: Path to the generated plan file
