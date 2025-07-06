resource "aws_launch_template" "this" {
  name_prefix   = "aws-ha-webapp-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.ec2_sg_id]
    subnet_id                   = element(var.private_subnets, 0)
  }

  user_data = filebase64("${path.module}/userdata.sh")
}

resource "aws_autoscaling_group" "this" {
  name                      = "aws-ha-webapp-asg"
  max_size                  = 6
  min_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = var.private_subnets
  health_check_type         = "EC2"
  target_group_arns         = [var.target_group_arn]
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "alb_attachment" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn    = var.target_group_arn
}
