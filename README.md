# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

   -  **MAJOR** version when you make incompatible API changes
   -  **MINOR** version when you add functionality in a backward compatible manner
   -  **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation intstructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs.

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed the bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI.

### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`
- For portability for different OS distributions
- Will search the user's path for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml, we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable, we need to change linux permission for the script to be executable at the user mode.

```sh
chmod 744 ./bin/install_terraform_cli
```

alternatively:

```sh
chmod u+x ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Initi, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

#### env command

We can list out all Enviroment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when running a single command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env var without writing export eg.

```
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will nto be aware of env vars that you have set in another window.

To set Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

#### Setting Persistant Env Vars in Gitpod

We can set env vars as persistent in gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world
```

All future workspaces launched will set the new env vars for all bash terminals opened in those workspaces.

You can also set env vars in `.gitpod.yml` but this should only contain non-sensative env vars.

## Install the AWS CLI

AWS CLI is installed for this project via the bash script [`./bin/isntall_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Varrs](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDATHPM5JIY28ONQX5NY",
    "Account": "123456789033",
    "Arn": "arn:aws:iam::777123400066:user/terraform-bootcamp-user"
}
```

We'll need to generate AWS CLI credentials from IAM User in order to use the AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources providers and modules from the Terraform registry located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** interface with APIs and allow resource creation through terraform.
- **Modules** are packages of terraform files that allow the make the terraform code modular, portable, and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console

We can see a list of Terraform commands by typing `terraform`

#### Terraform Init

At the start of every new Terraform project, run `terraform init`. This will download the binaries (written in GO) that are used in this project.

#### Terraform Plan

`terraform plan`

This generates a changeset about the current state of the infrastructure and what will be changed.

Output this changeset (plan) to be passed to an apply, but this is not necessary.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed. Apply prompts yes or no. Automatically approve apply with `terraform apply --auto-approve`.

#### Terraform Destroy

`terraform destroy`
This will destroy resources.

This command also accepts the auto approve flag eg. `terraform destroy --auto-approve`

#### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File should be committed to your Version Control System (VCS) eg. Github

#### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be committed** to your VCS. Accomplished by adding line to [.gitinore](.gitignore) file

`.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` in bash it will launch a wiswig view to generate a token. However this does not work as expected in Gitpod VSCode browser.

In the wiswig view, enter `p` to display the output and follow link: https://app.terraform.io/app/settings/tokens?source=terraform-login. Copy the token and return to Gitpod. Then enter `q` to quit wiswig and paste the token value into the prompt. 

Run: `cat /home/gitpod/.terraform.d/credentials.tfrc.json` to verify the file was created and contains the auth tokens.

Alternatively, if the previous steps did not create that file:

Follow this link:

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create the file manually and open the file: 

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Paste the following code into the file (include your copied token in the file):

```sh
{
  "credentials": {
    "app.terraform.io": {
      "token": "INSERT-TOKEN-HERE"
    }
  }
}
```

Automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

Created 