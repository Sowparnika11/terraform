resource "aws_iam_user" "test_user" {
  name = var.user_name
  tags = var.tags
}

# resource "aws_iam_user_policy" "sample_policy" {
#   name = "test"
#   user = aws_iam_user.test_user.name

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "ec2:Describe*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }