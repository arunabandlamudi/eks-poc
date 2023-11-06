variable "aws_region" {
  description = "AWS region in which resources has to create"
  type = string
  default = "ap-south-1"
}

variable "profile" {
  description = "AWS profile for authentication"
  type = string
  default = "terraform"
}