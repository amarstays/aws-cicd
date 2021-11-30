variable "pipeline_deployment_bucket_name" {
  description = "Bucket used by codepipeline and codebuild to store artifacts regarding the deployment"
  type        = string
}

variable "custom_tags" {
  description = "tags"
  type        = map(string)
}

variable "github_owner" {
  description = "GitHub owner name"
  type        = string
}

variable "github_repo" {
  description = "GitHub repo name"
  type        = string
}

variable "github_oauth_token" {
  description = "GitHub oauth token (pat works as well!)"
  type        = string
}