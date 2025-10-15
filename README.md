# Action Tofu

A GitHub Action to plan and apply OpenTofu modules with configurable backend and input parameters.

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

This action uses automatic semantic versioning with major version tag management. Every push to main creates a new version based on commit messages following [Angular Commit Message Conventions](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines):

- **Patch version** (default): `v1.0.1`, `v1.0.2`, etc.
  - `fix:` - bug fixes
  - `docs:`, `style:`, `refactor:`, `test:`, `chore:` - non-breaking changes
- **Minor version**: `v1.1.0`, `v1.2.0`, etc.
  - `feat:` - new features
- **Major version**: `v2.0.0`, `v3.0.0`, etc.
  - `BREAKING CHANGE:` in commit body or footer
  - `feat!:` or `fix!:` - breaking changes

**Major version tags are automatically updated:**
- When `v1.2.3` is released, the `v1` tag moves to point to `v1.2.3`
- This allows users to reference the latest version in a major series

Use in your workflows:
- `Imagimaps/action-tofu@v1` (latest v1.x - recommended)
- `Imagimaps/action-tofu@v1.2.3` (specific version)
- `Imagimaps/action-tofu@main` (development - not recommended)
