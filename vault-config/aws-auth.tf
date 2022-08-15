resource "aws_iam_user" "hcp_vault" {
  name = "hcp-vault"
  path = "/"
}

data "aws_iam_policy_document" "hcpvault_policy" {
  statement {
    effect = "allow"
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

resource "aws_iam_user_policy" "hcp_vault_auth_policy" {
  name = "hcp-vault-auth-policy"
  user = aws_iam_user.hcp_vault.name

  policy = data.aws_iam_policy_document.hcpvault_policy.json
}

resource "aws_iam_user_policy_attachment" "hcp_vault_attach" {
  user       = aws_iam_user.hcp_vault.name
  policy_arn = aws_iam_policy.hcp_vault_policy.arn
}

resource "aws_iam_access_key" "hcp_vault" {
  user = aws_iam_user.hcp_vault.name
}
