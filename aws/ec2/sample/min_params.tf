module "ec2_creation"{
    source      = "./code"
    location  = "eu-west-2"
    create = true
    create_spot_instance = false
    ami = "ami-0fb391cce7a602d1f"
    instance_type = "t3.micro"
    subnet_id = "subnet-073f346b28ccddaf6"
    vpc_security_group_ids = ["sg-073a6137f38de530c"]
    associate_public_ip_address = false
    disable_api_termination = true
    enable_volume_tags = false
    create_alarm = true
    alarm_name  = "cpu-utilization" 
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = 2
}