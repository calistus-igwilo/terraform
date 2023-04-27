variable "access_key" {
  description = "Access key to AWS console"
}

variable "secret_key" {
  description = "Secret key to AWS console"
}

variable "region" {
  description = "AWS region"
}

variable "db_user" {
    description = "MySQL username"
}

variable "db_password" {
  description = "MySQL password"
}

variable "instance_name" {
  description = "Value of the Name tag for EC2 instance"
  type        = string
  default     = "mms-server"

}