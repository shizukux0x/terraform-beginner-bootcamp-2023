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
