resource "aws_codepipeline" "codepipeline" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner                = var.github_owner
        Repo                 = var.github_repo
        Branch               = "main"
        PollForSourceChanges = "true"
        OAuthToken           = var.github_oauth_token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild-project.name
      }
    }
  }

  //  stage {
  //    name = "Deploy"
  //
  //    action {
  //      name            = "Deploy"
  //      category        = "Deploy"
  //      owner           = "AWS"
  //      provider        = "CloudFormation"
  //      input_artifacts = ["build_output"]
  //      version         = "1"
  //
  //      configuration = {
  //        ActionMode     = "REPLACE_ON_FAILURE"
  //        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
  //        OutputFileName = "CreateStackOutput.json"
  //        StackName      = "MyStack"
  //        TemplatePath   = "build_output::sam-templated.yaml"
  //      }
  //    }
  //  }
}