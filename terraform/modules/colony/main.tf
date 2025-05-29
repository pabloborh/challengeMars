module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "${var.environment}-${var.name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = var.environment
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "${var.environment}-${var.name}-eks"
  cluster_version = "1.29"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_size    = 2
      max_size        = 3
      min_size        = 2
      instance_types  = ["t3.medium"]
      capacity_type   = "ON_DEMAND"
    }
  }

  tags = {
    Environment = var.environment
  }
}

module "sqs_rover_updates" {
  source         = "../../modules/sqs"
  queue_name     = "${var.environment}-${var.name}-rover-updates"
  sns_topic_arn  = "arn:aws:sns:${var.aws_region}:${var.aws_account_id}:fleet-updates"
  environment    = var.environment
}