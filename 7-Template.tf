resource "aws_launch_template" "web_tier" {
 description = "Launch_Template"

 image_id = "ami-0a627a85fdcfabbaa"
 instance_type = "t3.micro"
 user_data = filebase64("user_data.sh")
 vpc_security_group_ids = [aws_security_group.weblb.id ]

 tags = {
    Name = "web-tier-server-template"
 }
 tag_specifications {
   resource_type = "instance"
   tags = {
    ManagedBy = "Terraform"
   }
 }

 lifecycle {
   create_before_destroy = true
 }

  }