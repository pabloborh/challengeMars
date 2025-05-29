module "alpha_colony"{
  source = "../../../modules/colony"
  name = "alpha"
  aws_region = "eu-west-1"
  environment = "dev"
  aws_account_id = "DEV-AWS-ACCOUNT"
}
