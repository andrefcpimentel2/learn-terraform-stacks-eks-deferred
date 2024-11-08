# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "development" {
  inputs = {
    cluster_name        = "stacks-demo"
    kubernetes_version  = "1.30"
    region              = "us-east-2"
    role_arn            = "arn:aws:iam::590643154400:role/stacks-AndrePimentel-stacks-demo"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}

