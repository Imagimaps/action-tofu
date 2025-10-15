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
    upgrade: true
    init_vars: |
      backend_bucket=my-state-bucket
      backend_region=us-east-1
    plan_vars: |
      environment=prod
      region=us-east-1
    apply: false
    upload_plan: true
```

## Inputs

- `tofu_version`: OpenTofu version to use (default: 'latest')
- `module_path`: Path to the OpenTofu module (required)
- `backend_config`: Backend configuration as multiline key=value pairs
- `upgrade`: Whether to upgrade modules and providers during init (default: false)
- `init_var_files`: Init variable files as multiline paths
- `init_vars`: Init variables as multiline key=value pairs  
- `plan_var_files`: Plan variable files as multiline paths
- `plan_vars`: Plan variables as multiline key=value pairs
- `apply`: Whether to apply the plan (default: false)
- `destroy`: Whether to destroy infrastructure (default: false)
- `upload_plan`: Upload plan file to GitHub artifacts (default: true)

## Outputs

- `plan_file`: Path to the generated plan file

## Versioning

This action uses automatic semantic versioning. Every push to main creates a new version:

- Default: patch version (v1.0.1, v1.0.2, etc.)
- `#minor` or `#feature` in commit message: minor version (v1.1.0)
- `#major` or `#breaking` in commit message: major version (v2.0.0)

Use specific versions in your workflows:
- `Imagimaps/action-tofu@v1` (latest v1.x)
- `Imagimaps/action-tofu@v1.0.1` (specific version)
