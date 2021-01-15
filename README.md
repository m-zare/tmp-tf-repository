# Agencies SFTP Server

We're helping a global financial institution with operations spanning six AWS regions as our customer.

Our customer works with 21 marketing agencies and companies all around the world and now as part of data lake project, we want to create a solution to those agencies to upload data to our S3 buckets. Being not very tech savvy, they ask for SFTP connection for **daily or weekly uploads.**

## Setup

Follow this instruction, To deploy agency required resources.

### Prerequisites

You will need [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) and [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) installed and configured.

### Clone repository

```bash
git clone https://github.com/m-zare/tmp-tf-repository.git
```

### Deploy AWS s3 backend

```bash
cd tmp-tf-repository/aws_infra
terraform init
terraform apply
```

### Deploy SFTP server and users

```bash
 cd ../agencies_sftp/
```

Open `variables.tf` in your favorite editor and edit `username` to reflect desired state.
In following case `user1` and `user2` are users to be created. Please note that you need to replace `public ssh-key` with the user's actual public SSH key.
This variable could contain as many users as agency needs.

```text
variable "username" {
  description = "SFTP user"

  default = {
    user1 = "public ssh-key"
    user2 = "public ssh-key"
  }
}
```

After `username` modification, run terraform.

```bash
terraform init
terraform apply
```

## Modification

To add or remove users, edit `agancies_sftp/variables.tf` as described in the above section. Then run `terraform apply`.

```bash
cd tmp-tf-repository/agencies_sftp/
terraform apply 
```

## Destroy

To destroy resources run `terraform destroy` in both `agancies_sftp` and `aws_infra` directories and answer `yes` to the questions.

```bash
cd tmp-tf-repository/agencies_sftp/
terraform destroy
cd ../aws_infra
terraform destroy
```
