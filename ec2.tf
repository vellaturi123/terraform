provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "terrInstance" {
        ami = "ami-0b0af3577fe5e3532"
        instance_type = "t2.micro"
        subnet_id = "${aws_subnet.privatesubnet.id}"
        associate_public_ip_address = true
        security_groups ="${aws_security_group.security_group.id}"

        tags = {
	Name = "Terraform Instance"
        }
}
resource "aws_key_pair" "name" {
    key_name = "sample"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5oDF0M9pX+frfGuzTPiLAkxrjYoO4TbsmxX8mOdk7UxXwtYcWlnb4TPN7yMygNW9JVr/DMaE+/vkJBlmthf0Lig4I8cOYYBD9IcaEbsoMR9FfyqFDJhJ5clF+4rlWC60C3eWkVpjhYGFYmi14u/AZ0fFCFuA1EW5IyD0d1B19gqlGbYO5qQ1mwpn6R+xGAsPAuflffG+70jkgLQb8gtJxE+2jJauW6rP1U9VqsNaTGZhJqfKhrEim4cgeZbh8lSTAAw8wxxajduTYv4+wkbdtj5uH1UBCLVPVL0aM+/dR1917UlJ65ECFFkOmGS0Q7wXRUna2k0xQRMn36OZ2OS2lglut3Kouyd9ZhBurYCGwVSNSC9FK6v+o/i8+5F/Ie04A53ntHXP+EAOvlhXMxURqjXtw3xxwu1kH47IASxJ0ysmiRQBNZTvEsNxcQxiHeMj0qVL5Rj2Swyl7DqAKq6qlsWbp6bN29HEZd0vfttyhB/mBenbz/4bbrTevDUTEUVc= lakshmi@LAPTOP-H77A5FR4"
  
}