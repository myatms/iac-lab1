variable "aws_region" {
  description = "The Region of AWS"
  type        = string
  #default     = "ap-southeast-1"

}
variable "aws_ami" {
  description = "AMI ID of Instance"
  type        = string
  #default     = "ami-0df7a207adb9748c7"

}
variable "aws_count" {
  description = "How Many Create"
  type        = number
  default     = 1

}