variable "cluster_id" {
  description = "The name of the HCP Consul cluster."
  type        = string
  default     = ""
}

variable "tier" {
  description = "The tier of the HCP Consul cluster."
  type        = string
  default     = "development"
}

variable "public_endpoint" {
  description = "The tier of the HCP Consul cluster."
  type        = bool
  default     = false
}

