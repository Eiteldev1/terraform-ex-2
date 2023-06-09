variable vpc_name {
  type        = string
  default     = "my_assg_vpc" 
  description = "vpc name"
}

variable vpc_cidr {
  type        = string
  default     = "30.45.0.0/16" 
  description = "vpc cidr"
}

variable azs {
    type = list
    default = ["us-east-1a", "us-east-1b"]
    description = "availabilty zones"
}

variable public_cidr {
  type        = string
  default     = "30.45.2.0/24"
  description = "public subnet cidr"
}

variable private_cidr {
  type        = string
  default     = "30.45.1.0/24"
  description = "private subnet cidr"
}

variable web_server_instance_name {
  type        = string
  default     = "web-server"
  description = "description"
}

variable app_server_instance_name {
  type        = string
  default     = "app-server"
  description = "description"
}

variable web_server_ami {
  type        = string
  default     ="ami-09988af04120b3591"
  description = "web-server amazon linux ami"
}

variable app_server_ami {
  type        = string
  default     ="ami-026ebd4cfe2c043b2"
  description = "app-server redhat ami"
}

variable web_server_instance_type {
  type        = string
  default     = "t2.micro"
  description = "web-server instance type"
}

variable app_server_instance_type {
  type        = string
  default     = "t2.micro"
  description = "app-server instance type"
}

variable env {
  type        = string
  default     = "dev"
  description = "locals vars"
}

variable team {
  type        = string
  default     = "alpha"
  description = "locals vars"
}