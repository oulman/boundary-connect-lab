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
