# auction-vesting-interface - Management - DevOps

 GitHub repository used to store infrastructure code related to auction-vesting-interface application.


## Initialization

In order to separate environments it was decided using workspaces.  

### Initial Components

- AWS S3 bucket for TF state
- `{environment}.hcl` file with backend configuration (AWS *S3 bucket*, *key*, *region*)  

### How to use

---

#### Initial setup (step by step)

1. Backend configuration:

    ```bash
    terraform init -backend-config=backend/{environment}.hcl
    ```

    where environment is `production`

2. Workspace creation and selection:

    > **NOTE**: When a workspace is created S3 automatically creates env/{environment} directory for tfstate

    ```bash
    terraform workspace new {environment}
    ```

3. Terraform plan:

    ```bash
    terraform plan -var-file=tfvars/{environment}.tfvars -out=terraform.tfplan
    ```

4. Terraform apply:

    ```bash
    terraform apply "terraform.tfplan"
    ```

5. After creating resources create new workspace:

    ```bash
    terraform workspace new {environment}
    ```

6. Repeat steps 1, 3 and 4  

---

> **NOTE**: When you need change workspace please do:

```bash
terraform workspace select {environment}
```

## Documentation

 To document the Terraform resources used the CLI tool [terraform-docs](https://terraform-docs.io/). After each Terraform code update please use the [terraform-docs.sh](terraform-docs.sh) file:

 ```bash
 bash terraform-docs.sh

 or

 ./terraform-docs.sh
 ```

 ---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.35.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |
| <a name="provider_aws.cloudfront"></a> [aws.cloudfront](#provider\_aws.cloudfront) | 5.35.0 |
| <a name="provider_aws.dns"></a> [aws.dns](#provider\_aws.dns) | 5.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/codepipeline) | resource |
| [aws_iam_policy.codebuild_policy](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/iam_role) | resource |
| [aws_iam_role.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codebuild_policy](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_record.a](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/route53_record) | resource |
| [aws_route53_record.caa](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/route53_record) | resource |
| [aws_route53_record.dns_validation](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/route53_record) | resource |
| [aws_s3_bucket.codepipeline_artifacts](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.codepipeline_artifacts](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.codepipeline_artifacts](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.codepipeline_artifacts](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_codestarconnections_connection.selected](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/codestarconnections_connection) | data source |
| [aws_iam_policy_document.codebuild_policy](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_artifacts](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codepipeline_role](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/region) | data source |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/5.35.0/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS - Profile | `string` | `"563576219775"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS - Region | `string` | `"eu-central-1"` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | AWS - Default tags | `map(any)` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | Route53 - Domain | `string` | `"voltage.finance"` | no |
| <a name="input_github_branch"></a> [github\_branch](#input\_github\_branch) | GitHub - Branch | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Global - Name | `string` | n/a | yes |
| <a name="input_website"></a> [website](#input\_website) | Application - Website hostnames | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->