module "alpha_colony"{
  source = "../../../modules/colony"
  name = "beta"
  aws_region = "eu-west-2"
  environment = "dev"
  aws_account_id = "DEV-AWS-ACCOUNT"
}
