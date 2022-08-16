##
## aws auth backend IAM configuration
##

resource "aws_iam_user" "hcp_vault" {
  name = "hcp-vault"
  path = "/"
}

data "aws_iam_policy_document" "hcpvault_policy" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "iam:GetInstanceProfile",
      "iam:GetUser",
      "iam:GetRole",
      "iam:ListRoles"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "hcp_vault_auth_policy" {
  name = "hcp-vault-auth-policy"

  policy = data.aws_iam_policy_document.hcpvault_policy.json
}

resource "aws_iam_user_policy_attachment" "hcp_vault_attach" {
  user       = aws_iam_user.hcp_vault.name
  policy_arn = aws_iam_policy.hcp_vault_auth_policy.arn
}

resource "aws_iam_access_key" "hcp_vault" {
  user = aws_iam_user.hcp_vault.name
}

##
## backend configuration
##

resource "vault_auth_backend" "aws" {
  type = "aws"
}

resource "vault_aws_auth_backend_client" "aws" {
  backend    = vault_auth_backend.aws.path
  access_key = aws_iam_access_key.hcp_vault.id
  secret_key = aws_iam_access_key.hcp_vault.secret
}

##
## roles
##

data "aws_caller_identity" "current" {}

resource "vault_aws_auth_backend_role" "nomad-server" {
  backend                         = vault_auth_backend.aws.path
  role                            = "nomad-server-role"
  auth_type                       = "iam"
  bound_vpc_ids                   = [data.terraform_remote_state.global.outputs.vpc_id]
  bound_subnet_ids                = [data.terraform_remote_state.global.outputs.private_subnets]
  bound_iam_instance_profile_arns = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/nomad-server"]
  inferred_entity_type            = "ec2_instance"
  inferred_aws_region             = "us-east-1"
  token_ttl                       = 60
  token_max_ttl                   = 120
  token_policies                  = ["default", "nomad-server", "nomad-cluster"]
}

resource "vault_aws_auth_backend_role" "nomad-client" {
  backend                         = vault_auth_backend.aws.path
  role                            = "nomad-client-role"
  auth_type                       = "iam"
  bound_vpc_ids                   = [data.terraform_remote_state.global.outputs.vpc_id]
  bound_subnet_ids                = [data.terraform_remote_state.global.outputs.private_subnets]
  bound_iam_instance_profile_arns = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/nomad-client"]
  inferred_entity_type            = "ec2_instance"
  inferred_aws_region             = "us-east-1"
  token_ttl                       = 60
  token_max_ttl                   = 120
  token_policies                  = ["default", "nomad-client", "nomad-cluster"]
}
