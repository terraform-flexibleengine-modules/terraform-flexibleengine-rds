data "flexibleengine_vpc_v1" "vpc" {
  name = var.vpc_name
}

data "flexibleengine_vpc_subnet_v1" "subnet_v1" {
  name = var.subnet_name
}

data "flexibleengine_networking_secgroup_v2" "secgrp_rds" {
  name = var.db_sg
}

resource "flexibleengine_rds_instance_v3" "instance" {
  availability_zone = var.rds_instance_az
  db {
    password = var.db_root_password
    type     = var.db_type
    version  = var.db_version
    port     = var.db_tcp_port
  }
  name              = var.rds_instance_name
  security_group_id = data.flexibleengine_networking_secgroup_v2.secgrp_rds.id
  subnet_id         = data.flexibleengine_vpc_subnet_v1.subnet_v1.id
  vpc_id            = data.flexibleengine_vpc_v1.vpc.id
  volume {
    type               = var.rds_instance_volume_type
    size               = var.rds_instance_volume_size
    disk_encryption_id = var.rds_instance_volume_encryption_id
  }
  flavor              = var.db_flavor
  ha_replication_mode = var.rds_ha_enable ? var.rds_ha_replicamode : null
  backup_strategy {
    start_time = var.db_backup_starttime
    keep_days  = var.db_backup_keepdays
  }
}

resource "flexibleengine_rds_read_replica_v3" "instances" {

  count = length(var.rds_read_replicat_list) > 0 ? length(var.rds_read_replicat_list) : 0

  name              = var.rds_read_replicat_list[count.index]["name"]
  flavor            = var.rds_read_replicat_list[count.index]["flavor"]
  availability_zone = var.rds_read_replicat_list[count.index]["availability_zone"]
  replica_of_id     = flexibleengine_rds_instance_v3.instance.id

  volume {
    type               = var.rds_read_replicat_list[count.index]["volume_type"]
    disk_encryption_id = var.rds_read_replicat_list[count.index]["disk_encryption_id"]
  }
}
