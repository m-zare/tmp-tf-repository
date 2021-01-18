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

### Customization

Open `agencies_sftp\sample.tfvars` and modify it to address your needs.
In the following sample `user1` and `user2` are users to be created. Please note that you can set public SSH key or path to the SSH public key file for each user. `username` variable could contain as many users as agency needs.
You can set `region` to the desired one.
`senderName` and `senderEmail` are holding notification sender name and email. `recipientEmail` is the one who should be notified. And the `scheduleExpression` is a cron pattern for sending out emails.

```text
region     = "eu-west-1"
production = false
username = {
  user1 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpyq9KM6h+bGuZNHktEmkwLL2BZ5xPifAZJ7k2GjS9ukpulh1AKuWUEIF74Lx1I1jQVKoGh9HkzFLmM7LEDl2viZ65hvKxIOw52X8GCJSLSJYujCyhXRA57cFJ1BDsDYf8/HiaXZ4tB11KpN3mB9a/xV9aYOpVRwUMuYFx42gYBjmIQkqM7vNOXwf6UxqLenFJHTsQkNhoI1kUsMQ9o357FCgar+05KtBNXDaSnAPazFrJWstskJS4FX+9aT1OPXmzcuCFDkPxwk/pG9axKDbUIScdC58MChd527HJZEWX0U7E6YJCqYxe/gXPpWeCrwiVNw4kJdVNDso8pdaEMckt"
  user2 = "~/sftp.pub"
}
senderName         = "AWS SFTP Notification System"
senderEmail        = "mostafazare@gmail.com"
recipientEmail     = "mostafazare@gmail.com"
scheduleExpression = "cron(0 8 * * ? *)"
```

### Deploy AWS s3 backend

**Initialize modules:**

```bash
cd tmp-tf-repository/aws_infra
terraform init
```

**Apply configuration:**

```bash
terraform apply
```

### Deploy SFTP server and users

**Initialize modules:**

```bash
 cd ../agencies_sftp/
 terraform init
```

**Apply configuration:**

```bash
terraform apply -var-file sample.tfvars
```

## Add/ remove/ update user

To add, remove or update user, edit `agencies_sftp\sample.tfvars` as described in the above section. Then run `terraform apply`.

```bash
cd tmp-tf-repository/agencies_sftp/
terraform apply -var-file sample.tfvars
```

## Destroy

To destroy resources run `terraform destroy` in both `agancies_sftp` and `aws_infra` directories and answer `yes` to the questions.

```bash
cd tmp-tf-repository/agencies_sftp/
terraform destroy
cd ../aws_infra
terraform destroy
```

### Note

For security reason you are not able to destroy a non-empty s3 bucket in AWS. 
In the `agancies_sftp` you can set `production` to `false` to ignore this constraint.

To be on safe side, destroying s3 bucket is not allowed in `aws_infra` (even with `production=false`). To destroy it you have to manually `Empty` the `sftp-terraform-state-bucket` bucket, then running `terraform destroy`.