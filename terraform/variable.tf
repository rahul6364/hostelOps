variable "ec2_ami_id" {
  description = "the ami id of the ec2 instance"
  type        = string
  default = "ami-06e3c045d79fd65d9" #ubuntu 22.04
 
}
variable "ec2_default_root_storage_size" {
  description = "the default root storage size of the ec2 instance"
  type        = number
  default     = 8
}
variable "ec2_instance_type" {
  description = "the instance type of the ec2 instance"
  type        = string
  default     = "t3.micro"
}