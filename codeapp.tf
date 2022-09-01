resource "aws_codedeploy_app" "java-codedeploy-app" {
  compute_platform = "Server"
  name             = "java-codedeploy-app"
}

resource "aws_iam_role" "codedeploy-service-role" {
  name = "codedeploy-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy-service-role.name

}

resource "aws_codedeploy_deployment_group" "java-codedeploy-group" {
  app_name               = aws_codedeploy_app.java-codedeploy-app.name
  deployment_group_name  = "java-codedeploy-group"
  service_role_arn       = aws_iam_role.codedeploy-service-role.arn
  autoscaling_groups     = [aws_autoscaling_group.asg.name]
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
  load_balancer_info {
    elb_info {
      name = aws_lb.alb.name
    }
  }


  auto_rollback_configuration {
    enabled = false
  }
}