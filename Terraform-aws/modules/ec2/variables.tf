variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}

variable "ec2_names" {
    description = "EC2 names"
    type = list(string)
    default = ["Web_server1", "Web_server2"]
}
