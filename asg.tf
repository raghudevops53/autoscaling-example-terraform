resource "aws_autoscaling_group" "asg" {
  name                      = "sample"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  force_delete              = true
  launch_template {
    id                      = aws_launch_template.asg.id
    version                 = "$Latest"
  }
  availability_zones = ["us-east-1a"]
}

resource "aws_launch_template" "asg" {
  name                      = "sample"
  image_id                  = data.aws_ami.ami.id
  instance_type             = "t2.micro"
}

data "aws_ami" "ami" {
  most_recent       = true
  owners            = ["973714476881"]
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_policy" "bat" {
  name                   = "cpu-based"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40.0
  }
}
