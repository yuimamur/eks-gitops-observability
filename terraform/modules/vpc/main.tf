module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.8"

  name = var.name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = [for i, az in var.azs : cidrsubnet(var.cidr, 4, i)]
  public_subnets  = [for i, az in var.azs : cidrsubnet(var.cidr, 4, i + 8)]

  enable_nat_gateway   = true
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true

  # EKSがこのVPC内でロードバランサーを配置する場所を判断するためのタグ
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
