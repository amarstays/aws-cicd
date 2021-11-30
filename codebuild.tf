resource "aws_codebuild_project" "codebuild-project" {
  name          = "codebuild-project"
  description   = "Codebuild Project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.codebuild_bucket.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    //    environment_variable {
    //      name  = "SOME_KEY1"
    //      value = "SOME_VALUE1"
    //    }
    //
    //    environment_variable {
    //      name  = "SOME_KEY2"
    //      value = "SOME_VALUE2"
    //      type  = "PARAMETER_STORE"
    //    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.codebuild_bucket.id}/build-log"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/amarstays/anagram-discussion.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "main"


  tags = var.custom_tags
}