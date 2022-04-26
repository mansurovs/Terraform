# VPC Variables
variable "region" {
  default       = "eu-central-1"
  description   = "AWS Region"
  type          = string
}

variable "vpc-cidr" {
  default       = "10.0.0.0/16"
  description   = "VPC CIDR Block"
  type          = string
}

variable "public-subnet-1-cidr" {
  default       = "10.0.11.0/24"
  description   = "Public Subnet 1 CIDR Block"
  type          = string
}

variable "public-subnet-2-cidr" {
  default       = "10.0.21.0/24"
  description   = "Public Subnet 2 CIDR Block"
  type          = string
}

variable "private-subnet-1-cidr" {
  default       = "10.0.12.0/24"
  description   = "Private Subnet 1 CIDR Block"
  type          = string
}

variable "private-subnet-2-cidr" {
  default       = "10.0.22.0/24"
  description   = "Private Subnet 2 CIDR Block"
  type          = string
}

variable "private-subnet-3-cidr" {
  default       = "10.0.13.0/24"
  description   = "Private Subnet 3 CIDR Block"
  type          = string
}

variable "private-subnet-4-cidr" {
  default       = "10.0.23.0/24"
  description   = "Private Subnet 4 CIDR Block"
  type          = string
}

variable "ssh-location" {
  default       = "0.0.0.0/0"
  description   = "IP Address that can SSH into EC2 (Bastion Host) Instance"
  type          = string
}

variable "endpoint-email" {
  default       = "avid.mansurov@gmail.com"
  description   = "a valid email address"
  type          = string
}

# variable "database-snapshot-identifier" {
#   default       = "arn of snapshot"
#   description   = "The Database Snapshot ARN"
#   type          = string
# }

# variable "database-instance-class" {
#   default       = "db.t2.micro"
#   description   = "The Database Instance Type"
#   type          = string
# }

# variable "database-instance-identifier" {
#   default       = ""
#   description   = "The Database Instance Identifier"
#   type          = string
# }

# variable "multi-az-deployment" {
#   default       = false
#   description   = "Create a Standby DB Instance"
#   type          = bool
# }



# variable "ssl-certificate-arn" {

#   default = ""
#   description   = "ssl certificate arn"
#   type          = string
# }