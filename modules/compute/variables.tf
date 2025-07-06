variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "private_subnets" {
  type = list(string)
}
variable "target_group_arn" {}
variable "ec2_sg_id" {}
