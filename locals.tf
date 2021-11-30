locals {
  buckets_to_lock = {
    codepipeline = aws_s3_bucket.codepipeline_bucket.id
    codebuild    = aws_s3_bucket.codebuild_bucket.id
  }
}
