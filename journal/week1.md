# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag:
```sh
git tag -d <tag_name>
```

Remotly delete a tag:
```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

Use the `var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_id"`.

#### var-file flag

The `var-file` flag overwrites workspace-specifc variables.

#### terraform.tfvars

This is the default file to load in terraform variables in bulk.

#### auto.tfvars

This file also contains terraform variables like **terraform.tfvars**. Files matching the format `*.auto.tfvars* are loaded automatically by Terraform for each run.

#### Order of Terraform Variables

Terraform offers multiple ways to set variables. The list below specifies how Terraform handles conflicting variables and which take precendent.

  1. Command-Line Variable Flags, e.g `-var` or `-var-file`
     - overwrite workspace-specific variables.
  3. Local Env Vars with `TF_VAR_` prefix
     - overwrite workspace-specific and `*.auto.tfvar` file variables.
  4. Workspace-Specific Variables
     - overwrites variable sets and variables loaded from files that share the same key, eg. `*.auto.tfvars` or `terraform.tfvars`.
  6. Workspace-Scoped Variable Sets
  7. Project-Scoped Variable Sets
  8. Global Variable Sets
  9. `*.auto.tfvars` Variable Files
      - overwrites variables in `terraform.tfvars` files.
      - overwritten by variables in the Terraform Cloud workspace and command line variables.
  11. `terraform.tfvars` Variable Files

### Tagging S3 Bucket

- TODO: document S3 bucket tagging

## Dealing with Configuration Drift

## What Happens If the TF State File is Lost?

Most likely, all cloud infra will need to be teared down.

Terraform import will work for some, but not all cloud resources. Refer to the Terraform Providers documentation for details on which resources support import. 

[Terraform Registry Providers](https://registry.terraform.io/browse/providers)

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If an individual deletes cloud resources manually, through ClickOps. 

Running `terraform plan`, with cause Terraform to attempt to return the infrastructure back to the expected state by fixing Configuration Drift.

### Fix Using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

[Terraform Refresh](https://developer.hashicorp.com/terraform/cli/commands/refresh)

## Terraform Modules

### Terraform Module Structure

It is recommonded to place modules in a `modules` directory when locally developing modules.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import a module from variable places, eg.:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations When Using ChatGPT to Write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be deprecated. Often affecting providers.

## Working with Files in Terraform

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Fileexists function

This a built-in Terraform function to check the exisitance of our files.

```tf
  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified file path does not exist."
  }
```
https://developer.hashicorp.com/terraform/language/functions/fileexists

### Path Variable

In Terraform, there is a special variable called `path` that isused to reference local paths:
- path.module = get the path of the current module
- path.root = get the path of the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


```tf
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"

  etag = filemd5(var.error_html_filepath)
}
```

## Terraform Locals

Locals are needed to define local variables.
It is very useful to reference cloud resources without importing them.

```tf
locals {
    s3_origin_id = "MyS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This enables sourcing data from cloud resources.

This is useful when referencing cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

Used to create the json policy inline in the hcl.

```tf
jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

**Ref:**

[Resource: aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

[Customize Terraform Configuration with Variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables)

[Workspace Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables#precedence)

[Managing Variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables#overwrite-variable-sets)

