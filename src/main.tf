terraform {
	required_version = "~> 1.5"

	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 5.46"
		}
		docker = {
			source  = "kreuzwerker/docker"
			version = "~> 3.0"
		}
	}
}

provider "aws" {
	region = "us-west-1"

	default_tags {
		tags = {
			environment          = "production"
			pii                  = false
			terragrunt_base_path = "1Mill/sandbox-aws-lambda-node-mjs/src"
		}
	}
}

data "aws_caller_identity" "this" {}
data "aws_ecr_authorization_token" "token" {}
data "aws_region" "current" {}

provider "docker" {
	registry_auth {
		address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
		password = data.aws_ecr_authorization_token.token.password
		username = data.aws_ecr_authorization_token.token.user_name
	}
}

locals {
	function_name = "sandbox-lambda"
	version       = "2024-10-07T21-00-00" # ! To deploy new code, this must be changed.
}

module "docker_image" {
	source  = "terraform-aws-modules/lambda/aws//modules/docker-build"
	version = "~> 7.2.6"

	create_ecr_repo      = true
	ecr_repo             = local.function_name
	image_tag            = local.version
	image_tag_mutability = "IMMUTABLE"
	keep_locally         = true
	keep_remotely        = true
	source_path          = abspath(path.module)
}

module "lambda" {
	source  = "terraform-aws-modules/lambda/aws"
	version = "~> 7.2.6"

	create_package = false
	function_name  = "sandbox-lambda"
	image_uri      = module.docker_image.image_uri
	package_type   = "Image"


	environment_variables = {
		MILL_IOTA_AWS_ACCESS_KEY_ID: "placeholder"
		MILL_IOTA_AWS_REGION: "us-east-1"
		MILL_IOTA_AWS_SECRET_ACCESS_KEY: "placeholder"
		MILL_IOTA_MONGO_DB: "placeholder"
		MILL_IOTA_MONGO_URI: "placeholder"
		MILL_IOTA_SERVICE_ID: "sandbox-lambda"
	}
}
