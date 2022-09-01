data "template_file" "userdata" {
  template = file("userdata.sh")
}
resource "aws_iam_role" "s3bucket-service-role" {
  name               = "s3bucket-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "AmazonS3FullAccess" {
  name = "AmazonS3FullAccess"
  path = "/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      }
    ]
  })

}
resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
  policy_arn = aws_iam_policy.AmazonS3FullAccess.arn
  role       = aws_iam_role.s3bucket-service-role.name

}
resource "aws_iam_instance_profile" "s3FullAccessforEc2" {
  name = "test_profile"
  role = aws_iam_role.s3bucket-service-role.name
}


resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = var.launch-config-name
  image_id                    = var.instance-ami
  instance_type               = var.instance-type
  iam_instance_profile        = aws_iam_instance_profile.s3FullAccessforEc2.name
  key_name                    = "ansible"
  user_data                   = base64encode(data.template_file.userdata.rendered)
  associate_public_ip_address = var.instance-associate-public-ip == "true" ? true : false
  security_groups             = ["sg-02397964d0fd5b7c3","sg-0c445e7aeca990351"]
}

resource "aws_autoscaling_group" "asg" {
  # name                      = "${var.asg-name}"
  name                      = aws_launch_configuration.launch_config.name
  min_size                  = var.asg-min-size
  desired_capacity          = var.asg-def-size
  max_size                  = var.asg-max-size
  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = ["subnet-0337d31878ab4be76", "subnet-09cbf59af609b530c"]
  target_group_arns         = ["${aws_lb_target_group.lb_target.arn}"]
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  min_elb_capacity          = var.asg-min-size

  lifecycle {
    create_before_destroy = true
  }

  # tags = ["${concat(
  # local.common_tags_asg,
  #tolist(
  # [tomap({Name ="${var.instance-tag-name}",value = "tag.value",key = "tag.value",propagate_at_launch=true})]
  # )
  #)}"]

  tags = (concat(
    local.common_tags_asg,
    tolist(
      [tomap({ Name = "${var.instance-tag-name}" })]
  )))
}