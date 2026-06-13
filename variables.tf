variable "region" {
  description = "AWS region"
  type        = string  
}

variable "vpc_cidr" {
  description = "CIDR block for vpc"
  type        = string  
}

variable "public_subnet_cidrs" {
  description = "public subnet CIDRs"
  type        = list(string)  
}

variable "private_subnet_cidrs" {
  description = "private subnet CIDRs"  
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)  
}