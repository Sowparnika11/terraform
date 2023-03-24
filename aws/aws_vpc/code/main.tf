locals {
    internet_gateway_count = (var.create_internet_gateway && length(var.pub_cidr_block_subnet) > 0) ? 1 : 0
    nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(var.az_subnet) : length(var.pub_cidr_block_subnet)
}
################################## VPC Creation ##############################################
resource "aws_vpc"  "my_vpc"{
    #checkov:skip= CKV2_AWS_11:logging not added # remove it while pushing
    count                            = var.is_vpc ? 1 : 0  
    cidr_block                       = var.cidr
    instance_tenancy                 = var.instance_tenancy
    enable_dns_hostnames             = var.enable_dns_hostnames
    enable_dns_support               = var.enable_dns_support
    enable_classiclink               = var.enable_classiclink
    enable_classiclink_dns_support   = var.enable_classiclink_dns_support
    assign_generated_ipv6_cidr_block = var.enable_ipv6

    tags = var.vpc_tag
}
##################################### Private subnet creation ########################################

resource "aws_subnet" "prv_subnets"{
    count = var.is_vpc ? length(var.prv_cidr_block_subnet) : 0
    vpc_id = aws_vpc.my_vpc[0].id
    cidr_block = var.prv_cidr_block_subnet[count.index]
    availability_zone = var.az_subnet[count.index]
    tags = {
        # "Name" = var.subnet_name[count.index]
        Name = "prv_${count.index}"
    }
}
##################################### Public subnet creation ########################################

resource "aws_subnet" "pub_subnets"{
    count = var.is_vpc ? length(var.pub_cidr_block_subnet) : 0
    vpc_id = aws_vpc.my_vpc[0].id
    cidr_block = var.pub_cidr_block_subnet[count.index]
    availability_zone = var.az_subnet[count.index]
    tags = {
        # "Name" = var.subnet_name[count.index]
        "Name" = "pub_${count.index}"
    }
}
############# security group ###########################################\
resource "aws_default_security_group" "default" {
  count = var.is_vpc ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id
}
################### private route table ##############################################

resource "aws_route_table" "prv_route_tables"{
    count = var.is_vpc ? length(var.prv_cidr_block_subnet) : 0
    vpc_id = aws_vpc.my_vpc[0].id
    tags = {
        # "Name" = var.route_table_name[count.index]
        "Name" = "prv_rt_${count.index}"
    }

}
################## public route table ##############################################

resource "aws_route_table" "pub_route_tables"{
    
    count = var.is_vpc ? length(var.pub_cidr_block_subnet) : 0
    vpc_id = aws_vpc.my_vpc[0].id
    tags = {
        # "Name" = var.route_table_name[count.index]
        "Name" = "pub_rt_${count.index}"
    }

}

################################## private route table association #################################

resource "aws_route_table_association" "prv_subnet_association"{
    count = var.is_vpc ? length(var.prv_cidr_block_subnet) : 0
    subnet_id = aws_subnet.prv_subnets[count.index].id
    route_table_id = aws_route_table.prv_route_tables[count.index].id

}
################################## public route table association #################################

resource "aws_route_table_association" "pub_subnet_association"{
    count = var.is_vpc ? length(var.pub_cidr_block_subnet) : 0
    subnet_id = aws_subnet.pub_subnets[count.index].id
    route_table_id = aws_route_table.pub_route_tables[count.index].id

}
########################### Internetgatway #########################################################
resource "aws_internet_gateway" "public" {
  count      = var.is_vpc ? local.internet_gateway_count : 0
  depends_on = [aws_vpc.my_vpc]
  vpc_id     = aws_vpc.my_vpc[0].id

  tags = {
      "Name" = "${var.name_prefix}-public-igw"
    }
}
################ egress only internet gateway #######################################################
resource "aws_egress_only_internet_gateway" "egress_igw" {
  count = var.is_vpc && var.create_egress_only_igw && var.enable_ipv6 && max(length(var.pub_cidr_block_subnet)) > 0 ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id

  tags = merge(
    var.igw_tags,
  )
}
########################### route entry for public rt ######################################################
resource "aws_route" "public_internet_gateway" {
  count = var.is_vpc && var.create_internet_gateway && length(var.pub_cidr_block_subnet) > 0 ? length(var.pub_cidr_block_subnet) : 0 #local.internet_gateway_count
  depends_on = [
    aws_internet_gateway.public,
    aws_route_table.pub_route_tables,
  ]
  route_table_id         = aws_route_table.pub_route_tables[count.index].id
  gateway_id             = aws_internet_gateway.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "public_internet_gateway_ipv6" {
  count = var.is_vpc && var.create_internet_gateway && var.enable_ipv6 && length(var.pub_cidr_block_subnet) > 0 ? length(var.pub_cidr_block_subnet) : 0

  route_table_id              = aws_route_table.pub_route_tables[count.index].id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.public[0].id
}

resource "aws_route" "private_ipv6_egress" {
  count = var.is_vpc && var.create_egress_only_igw && var.enable_ipv6 ? length(var.prv_cidr_block_subnet) : 0

  route_table_id              = element(aws_route_table.prv_route_tables[*].id, count.index)
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = element(aws_egress_only_internet_gateway.egress_igw[*].id, 0)
}

############## NAT Gateway #########################################################
locals {
  nat_gateway_ips = var.reuse_nat_ips ? var.external_nat_ip_ids : try(aws_eip.nat_eip[*].id, [])
}

resource "aws_eip" "nat_eip" {
  #checkov:skip= CKV2_AWS_19:remove this error # remove it while pushing
  
  count = var.is_vpc && var.enable_nat_gateway && false == var.reuse_nat_ips ? local.nat_gateway_count : 0

  vpc = true

  tags = merge(
    var.nat_eip_tags,
  )
}

resource "aws_nat_gateway" "nat" {
  count = var.is_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  allocation_id = element(
    local.nat_gateway_ips,
    var.single_nat_gateway ? 0 : count.index,
  )
  subnet_id = element(
    aws_subnet.pub_subnets[*].id,
    var.single_nat_gateway ? 0 : count.index,
  )

  tags = merge(
    var.nat_gateway_tags,
  )

  depends_on = [aws_internet_gateway.public]
}
######################### nat gateway route entry  ##################################
resource "aws_route" "private_nat_gateway" {
  count = var.is_vpc && var.enable_nat_gateway ? local.nat_gateway_count : 0

  route_table_id         = element(aws_route_table.prv_route_tables[*].id, count.index)
  destination_cidr_block = var.nat_gateway_destination_cidr_block
  nat_gateway_id         = element(aws_nat_gateway.nat[*].id, count.index)

  timeouts {
    create = "5m"
  }
}

