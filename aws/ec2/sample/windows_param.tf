module "ec2_creation"{
  source    = "./code"
  location  = "eu-west-2"
  create = true 
  create_spot_instance = false
  ami = "ami-04e0ebd20d57a72c1"
  instance_type = "t3.micro"
  subnet_id = "subnet-073f346b28ccddaf6"
  vpc_security_group_ids = ["sg-073a6137f38de530c"]
  associate_public_ip_address = false
  disable_api_termination = true
  enable_volume_tags = false
  is_block_device    = true
  is_ebs_required   = true
  root_block_device = [
      {
        encrypted   = true
        volume_type = "gp3"
        throughput  = 200
        volume_size = 50
        tags = {
          Name = "my-root-block"
        }
      },
    ]
  ebs_block_device = [
      {
        volume_type = "gp3"
        volume_size = 5
        throughput  = 200
        encrypted   = true
      }
    ]
  metadata_http_endpoint_enabled = true
  metadata_tags_enabled = false
  metadata_http_tokens_required = true
  is_launch_template = false
  ebs_block_device_name ="/dev/sdf"
  ssh_key_pair   = "test-key" # rename ssh Key
  get_password = true # only for windows use ssh key to decrypt the password in console
  create_alarm = true 
  alarm_name  = "cpu-utilization" 
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period  = 120
  statistic = "Average"
  threshold = 80
  alarm_description = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}

