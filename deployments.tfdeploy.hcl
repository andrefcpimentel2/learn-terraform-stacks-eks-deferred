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

deployment "PreProd" {
  inputs = {
    cluster_name        = "stacks-demo-PreProd"
    kubernetes_version  = "1.30"
    region              = "us-east-2"
    role_arn            = "arn:aws:iam::590643154400:role/stacks-AndrePimentel-stacks-demo"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}

deployment "QA" {
  inputs = {
    cluster_name        = "stacks-demo-QA"
    kubernetes_version  = "1.30"
    region              = "us-east-2"
    role_arn            = "arn:aws:iam::590643154400:role/stacks-AndrePimentel-stacks-demo"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}

deployment "QA2" {
  inputs = {
    cluster_name        = "stacks-demo-QA2"
    kubernetes_version  = "1.30"
    region              = "us-east-2"
    role_arn            = "arn:aws:iam::590643154400:role/stacks-AndrePimentel-stacks-demo"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}

deployment "production" {
  inputs = {
    cluster_name        = "stacks-demo-prod"
    kubernetes_version  = "1.30"
    region              = "us-east-2"
    role_arn            = "arn:aws:iam::590643154400:role/stacks-AndrePimentel-stacks-demo"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}

orchestrate "auto_approve" "safe_plans" {
    # Ensure that no resource is removed.
    check {
        condition = context.plan.changes.remove == 0
        reason    = "Plan is destroying ${context.plan.changes.remove} resources."
    }

    # Ensure that the deployment is not your production environment. 
    check {
        condition = context.plan.deployment != deployment.production
        reason    = "Production plans are not eligible for auto_approve."
    }
}