module "common" {
  source = "../../../modules/common"
}

module "aws_vpc" {
  source     = "../../../modules/vpc"
  commonTags = module.common.common_output_tags
}

module "subnet" {
  source     = "../../../modules/subnets"
  vpcId      = module.aws_vpc.kabe_vpc_id
  countTwo   = module.common.count_two
  commonTags = module.common.common_output_tags
}

module "ec2" {
  source                  = "../../../modules/ec2"
  publicSubnetOne         = module.subnet.kabe_public_subnet_ids[0]
  privateSubnets          = [module.subnet.kabe_private_subnet_ids[0], module.subnet.kabe_private_subnet_ids[1]]
  ec2VpcSecurityGroups    = module.aws_security_group.ec2_vpc_security_groups_ids
  webServerSecurityGroups = module.aws_security_group.web_server_security_groups
  countTwo                = module.common.count_two
  albTargetGroupsArn      = module.aws_lb.kabe-target-group-arn
  ec2IntanceProfile       = module.aws_iam_role.ec2_profile_instance
  commonTags              = module.common.common_output_tags

}

module "aws_security_group" {
  source     = "../../../modules/security_groups"
  vpcId      = module.aws_vpc.kabe_vpc_id
  commonTags = module.common.common_output_tags
}

module "aws_internet_gateway" {
  source           = "../../../modules/internet_gateway"
  countTwo         = module.common.count_two
  vpcId            = module.aws_vpc.kabe_vpc_id
  publicSubnetsIds = flatten(module.subnet.kabe_public_subnet_ids)
  commonTags       = module.common.common_output_tags
}


module "aws_nat_gateway" {
  source            = "../../../modules/nat_gateway"
  countTwo          = module.common.count_two
  vpcId             = module.aws_vpc.kabe_vpc_id
  publicSubnetsIds  = flatten(module.subnet.kabe_public_subnet_ids)
  privateSubnetsIds = flatten(module.subnet.kabe_private_subnet_ids)
  commonTags        = module.common.common_output_tags
}

module "aws_lb" {
  source              = "../../../modules/alb"
  albSecurityGroupIds = module.aws_security_group.alb_security_groups
  publicSubnetsIds    = module.subnet.kabe_public_subnet_ids
  vpcId               = module.aws_vpc.kabe_vpc_id
  commonTags          = module.common.common_output_tags
}

# module "rds" {
#   source           = "../../../modules/rds"
#   rdsPrivateSubnet = [module.subnet.kabe_private_subnet_ids[2], module.subnet.kabe_private_subnet_ids[3]]
#   rdsSecurityGroup = module.aws_security_group.rds_security_groups
#   commonTags       = module.common.common_output_tags

# }

module "aws_s3_bucket" {
  source     = "../../../modules/s3"
  vpcId      = module.aws_vpc.kabe_vpc_id
  commonTags = module.common.common_output_tags
}

module "aws_iam_role" {
  source      = "../../../modules/iam"
  s3BucketArn = module.aws_s3_bucket.s3BucketArn
  commonTags  = module.common.common_output_tags
}

module "aws_dynamodb_table" {
  source     = "../../../modules/dynamodb"
  commonTags = module.common.common_output_tags
}



