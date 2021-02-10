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
