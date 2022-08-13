variable "vpc_name" {
  description = "Name to be used on all the VPC module resources as identifier"
  type        = string
  default     = "boundary-connect-lab-vpc"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "vpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}



variable "hcp_hvn_id" {
  description = "The ID of the HCP HVN."
  type        = string
  default     = "hcp-aws-use1-hvn"
}

variable "hcp_region" {
  description = "The region of the HCP HVN and Consul cluster."
  type        = string
  default     = "us-east-1"
}

variable "hcp_cloud_provider" {
  description = "The cloud provider of the HCP HVN and Consul cluster."
  type        = string
  default     = "aws"
}

variable "hcp_peering_id" {
  description = "The ID of the HCP consul peering connection."
  type        = string
  default     = "hcp-aws-use1-peering"
}

variable "hcp_route_id" {
  description = "The ID of the HCP HVN route."
  type        = string
  default     = "hcp-aws-use1-route"
}
