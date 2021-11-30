# AWS pipeline CI-CD pipeline to build node app from github repo

### About

Once this pipeline is deployed, any new coded changes to the source code repo will trigger the pipleine. The pipeline will provision the required resources, make a build and run a sample test and once sucessful, change the build status to success.

## prerequisites (on Local or runner system (VM/container))

- git (version > 2.2): install from https://git-scm.com/downloads)
- aws-cli (>2.1.6): install from https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- terraform (> 1.0.11): install from https://www.terraform.io/downloads.html)
- github oAuth token for the code is available
- aws-cli is configured with right IAM user (User with programmatic access to S3 bucket, code build, code-pipeline, EC2 ) (you need to provide access id and secret key along with the region)

## Steps to run (this will deploy the entire pipeline)

1. Ensure that prerequisite are satisfied (all the above tools should be in path or accessible from the terminal/command line)
2. Clone this repo on runner system
3. Place the terminal inside AWS-CICD directory
4. run `terraform init`. This will intialize the terraform and download the needed providers and modules.
5. run `terraform plan`. You can ignore the warning if any.
6. Provide the details (if prompted) as and when needed.
7. If everything looks great, run `terraform apply`. Provide the needed details. If completed successfully, the pipeline is deployed.

## Clean-up

-run `terraform destroy` and provide the details when prompted. This will delete the aws resources.
