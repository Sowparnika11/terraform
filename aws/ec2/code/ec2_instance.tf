resource "aws_instance" "test_instance"{
  count                                = var.create && !var.create_spot_instance ? 1 : 0
  ami                                  = var.ami
  availability_zone                    = var.availability_zone
  instance_type                        = var.instance_type
  subnet_id                            = var.subnet_id
  user_data                            = var.user_data
  # user_data_base64                     = var.user_data_base64
  vpc_security_group_ids               = var.vpc_security_group_ids
  
  ebs_optimized                        = var.ebs_optimized
  disable_api_termination              = var.disable_api_termination
  
  iam_instance_profile                 = var.instance_profile
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  associate_public_ip_address          = var.associate_public_ip_address
  key_name                             = var.ssh_key_pair
  
  monitoring                           = var.monitoring
  private_ip                           = var.private_ip
  source_dest_check                    = var.source_dest_check
  get_password_data                    = var.get_password
  
  dynamic "root_block_device" {
    for_each = var.is_block_device && var.root_block_device != null ? var.root_block_device : []
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags                  = lookup(root_block_device.value, "tags", null)
    }
  }
  dynamic "ebs_block_device" {
    for_each = var.is_ebs_required && var.ebs_block_device !=null ? var.ebs_block_device : []
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = var.ebs_block_device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
    }
  }

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint_enabled ? "enabled" : "disabled"
    instance_metadata_tags      = var.metadata_tags_enabled ? "enabled" : "disabled"
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = var.metadata_http_tokens_required ? "required" : "optional"
  }

  credit_specification {
    cpu_credits = var.cpu_credits
  }
  dynamic "launch_template" {
    for_each = var.launch_template != null && var.is_launch_template ? [var.launch_template] : []
    content {
      id      = lookup(var.launch_template, "id", null)
      name    = lookup(var.launch_template, "name", null)
      version = lookup(var.launch_template, "version", null)
    }
  }
  timeouts {
    create = lookup(var.timeouts, "create", null)
    update = lookup(var.timeouts, "update", null)
    delete = lookup(var.timeouts, "delete", null)
  }

  tags = var.tags
  volume_tags = var.enable_volume_tags ? var.volume_tags : null
}
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
     count                     = var.create_alarm ? 1 :0         
     alarm_name                = var.alarm_name
     comparison_operator       = var.comparison_operator
     evaluation_periods        = var.evaluation_periods
     metric_name               = var.metric_name
     namespace                 = var.namespace
     period                    = var.period #seconds
     statistic                 = var.statistic
     threshold                 = var.threshold
     alarm_description         = var.alarm_description
     insufficient_data_actions = var.insufficient_data_actions
     dimensions = {
      InstanceId = aws_instance.test_instance[count.index].id
      }
}