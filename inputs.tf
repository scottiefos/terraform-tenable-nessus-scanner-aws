## Provision a Nessus Scanner ##

variable "scanner_name" {
  description = "nessus_scanner"
  type        = string
  default     = null
}

variable "tenable_linking_key" {
  description = "1d69dbdfea2505487f96fe3dab601fa079f453219e34d3cd1fcbf8bc2f82c4c0"
  type        = string
}

variable "vpc_id" {
  description = "vpc-23c3125e"
  type        = string
}

variable "subnet_id" {
  description = "subnet-59b0353f"
  type        = string
}

variable "instance_type" {
  description = "t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "nessus_scanner"
  type        = string
  default     = null
}

variable "instance_tags" {
  description = "A map of tags to apply to the instance"
  type        = map
  default     = {}
}

variable "use_eip" {
  description = "Whether or not to use an Elastic IP address with the Nessus scanner. Defaults to true because the documentation says it is required."
  type        = bool
  default     = true
}

## Process some inputs into a map of tags, then use those instead

locals {
  instance_name = coalesce(
    var.instance_name,                       # Prefer explicit name input
    lookup(var.instance_tags, "Name", null), # Allow naming with tags
    "nessus-scanner"                         # Default instance name
  )
  instance_tags = merge(var.instance_tags, { "Name" = local.instance_name }) # The right-most map's value always wins
}
