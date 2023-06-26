module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "bastion security group"
  description = "opening port 22 for ssh"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
egress_rules = [
"all-all"
]
  egress_cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_instance" "bastion_host" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.small"
  key_name      = "project-key-pair"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion_sg.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion"
  }

}
