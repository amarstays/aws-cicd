resource "aws_s3_bucket" "codebuild_bucket" {
  bucket = "${var.pipeline_deployment_bucket_name}-codebuild-amresh"
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
  tags = var.custom_tags
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.pipeline_deployment_bucket_name}-codepipeline-amresh"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
  # Neede for CloudWatch
  versioning {
    enabled = true
  }

  tags = var.custom_tags
}

resource "aws_s3_bucket_public_access_block" "pipeline_buckets" {

  for_each                = local.buckets_to_lock
  bucket                  = each.value
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
