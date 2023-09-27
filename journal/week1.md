# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Struture

The root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf    # everything else.
├── variables.tf    # stores the structure of input variables
├── terraform.tfvars    # the data of variables loaded into terraform project
├── providers.tf    # defined required providers and their configuration
├── outputs.tf    # stores the outputs
└── README.md    # required for root modules
```



  [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform, two types of variables can be set:
  - Enviroment Variables - those set in the bash terminal eg. AWS credentials
  - Terraform Variables - those set in tfvars file


Terraform Cloud variables can be set to sensitive, so they are not exposed in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

#### var flag

Use the `var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_id"`

#### var-file flag

The `var-file` flag overwrites workspace-specifc variables

#### terraform.tfvars

This is the default file to load in terraform variables in bulk. 

#### auto.tfvars

This file also contains terraform variables like **terraform.tfvars**. Files matching the format `*.auto.tfvars* are loaded automatically by Terraform for each run.

#### Order of Terraform Variables

Terraform offers multiple ways to set variables. The list below specifies how Terraform handles conflicting variables and which take precendent.

  1. Command-Line Variable Flags, e.g `-var` or `-var-file`
     - overwrite workspace-specific variables
  3. Local Env Vars with `TF_VAR_` prefix
     - overwrite workspace-specific and `*.auto.tfvar` file variables
  4. Workspace-Specific Variables
     - overwrites variable sets and variables loaded from files that share the same key, eg.                 `*.auto.tfvars` or `terraform.tfvars`.
  6. Workspace-Scoped Variable Sets
  7. Project-Scoped Variable Sets
  8. Global Variable Sets
  9. `*.auto.tfvars` Variable Files
      - overwrites variables in `terraform.tfvars` files
      - overwritten by variables in the Terraform Cloud workspace and command line variables.
  11. `terraform.tfvars` Variable Files

### Tagging S3 Bucket

- TODO: document S3 bucket tagging

**Ref:**

[Resource: aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

[Customize Terraform Configuration with Variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables)

[Workspace Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables#precedence)

[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables#overwrite-variable-sets)

