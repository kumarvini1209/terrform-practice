    variable "ami_id" {
        type = string
        default = ""
        description = "The AMI ID to use for the EC2 instance" #optional description for the variable"
    }

    variable "instance_type" {
        type = string
        default = ""
         description = "The type of instance to use for the EC2 instance" #optional description for the variable
      
    }

    variable "name" {
    type = string
    description = "The name of the EC2 instance" #optional description for the variable
    default = ""
  
}