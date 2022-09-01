# resource "aws_security_group" "sg" {
#   name   = var.sg-tag-name
#   vpc_id = "vpc-0d398f43f914a0f0c"

#   ingress {
#     protocol    = "tcp"
#     from_port   = "22"
#     to_port     = "22"
#     security_groups = [aws_security_group.sg_alb.id]
#   }

#   ingress {
#     protocol        = "tcp"
#     from_port       = "80"
#     to_port         = "80"
#     security_groups = [aws_security_group.sg_alb.id]
#   }

#   ingress {
#     protocol        = "tcp"
#     from_port       = "443"
#     to_port         = "443"
#     security_groups = [aws_security_group.sg_alb.id]
#   }

#   ingress {
#     protocol        = "tcp"
#     from_port       = "8080"
#     to_port         = "8080"
#     security_groups = [aws_security_group.sg_alb.id]
#   }

#   egress {
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = "0"
#     to_port     = "0"
#   }

#   tags = (merge(
#     local.common_tags,
#     tomap({ Name = "${var.sg-tag-name}" })
#   ))
# }

# # Security Group for ALB
# resource "aws_security_group" "sg_alb" {
#   name   = var.sg-alb-tag-name
#   vpc_id = "vpc-0d398f43f914a0f0c"

#   ingress {
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = "80"
#     to_port     = "80"
#   }

#   ingress {
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = "443"
#     to_port     = "443"
#   }

#   egress {
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = "0"
#     to_port     = "0"
#   }

#   tags = (merge(
#     local.common_tags,
#     tomap({ Name = "${var.sg-alb-tag-name}" })
#   ))
# }