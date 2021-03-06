variable "db_type" {
  description = "Type of database. Can be MySQL, PostgreSQL, SQLServer"
  default     = ""
}

variable "db_version" {
  description = "Version of database. Check Terraform and FE documentation to get version list"
  default     = ""
}

variable "db_flavor" {
  description = "Flavor of database. Check Terraform and FE documentation to get flavor list"
  default     = ""
}

variable "db_sg" {
  description = "name of RDS security group to create"
  default     = ""
}

variable "db_tcp_port" {
  description = "TCP port of database"
  default     = ""
}

variable "db_backup_starttime" {
  description = "start time of database backup (Exemple : 08:00-09:00)"
  default     = "01:00-02:00"
  type        = string
}

variable "db_backup_keepdays" {
  description = "keep days of database backup"
  default     = 3
  type        = number
}

variable "db_root_password" {
  description = "root password of RDS"
  default     = ""
  type        = string
}

variable "rds_ha_enable" {
  description = "To enable HA of RDS"
  default     = false
  type        = bool
}

variable "rds_ha_replicamode" {
  description = "To enable HA of RDS"
  default     = ""
  type        = string
}

variable "subnet_name" {
  description = "Name of the data subnet"
  default     = ""
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = ""
  type        = string
}

variable "rds_instance_name" {
  description = "name of RDS instances"
  default     = ""
  type        = string
}

variable "rds_instance_volume_type" {
  description = "Volume type of instances"
  default     = "COMMON"
  type        = string
}

variable "rds_instance_volume_size" {
  description = "Volume size of instances"
  default     = 0
  type        = number
}

variable "rds_instance_volume_encryption_id" {
  description = "KMS Key id for encryption"
  default     = null
  type        = string
}

variable "rds_instance_az" {
  description = "Availability zones of RDS instance (Multiple AZ must be specified if you are using HA)"
  default     = ["eu-west-0a"]
  type        = list(string)
}

variable "rds_read_replicat_list" {
  type = list(object({
    name               = string
    flavor             = string
    availability_zone  = string
    volume_type        = string
    disk_encryption_id = string
  }))
}
