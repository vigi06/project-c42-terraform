module "jenkins_sg1" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ssh service for jenkins and application"
  description = "opening all ports"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules = [
 "all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "Jenkins_host" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.medium"
  key_name      = "project-key-pair"
  subnet_id     = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.jenkins_sg1.security_group_id]


  tags = {
    Name = "Jenkins"
  }

}
