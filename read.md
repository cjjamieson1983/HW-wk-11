Building your VPC file in Terraform 

1.) Create your VPC subnet Architecture, and Region.

Region, Ohio

CIDR Range: 10.221.0.0/16

Public

10.221.1.0/24
10.221.2.0/24
10.221.3.0/24

Private

10.221.11.0/24
10.221.12.0/24
10.221.13.0/24

2.) Go to [aws_vpc | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) to find code for your VPC resource. Make sure you have your correct terraform version selected when pulling documentation.

3.) Copy Basic usage with Tags

resource "aws_vpc" "main" {
cidr_block       = "10.0.0.0/16"
instance_tenancy = "default"

tags = {
Name = "main"
}
}

4.) Edit your Resource Name and Tags, and CIDR. Add arguments to Enable DNS Host name + support.

```
resource "aws_vpc" "Nov1" {
  cidr_block           = "10.221.0.0/16"
  instance_tenancy     = "default" # optional, default option is setting this argument to default
  enable_dns_hostnames = true
  enable_dns_support   = true # optional, defaults to true 

  tags = {
    Name = "terraform-vpc"
  }
}
```

5.) Terraform IPAD workflow. Validate, Plan and Apply changes if code is valid.

6.) Create 2-subnets file in your folder. From Theo’s repo copy the subnets file.

https://github.com/malgus-waf/class5

7.) Edit your Subnet Names, CIDRs, VPC id’s To match your VPC architecture and that in your VPC file.

8.) Terraform IPAD workflow again.

9.) Create 3-IGW terraform file in your folder

https://github.com/malgus-waf/class5

10.) From Theo’s Repo copy the IGW file

Edit the names of your vpc id and Name your IGW for AWS, and run your Terraform IPAD  workflow.

11.) Create a 4-Nat terraform file , go to Aarrons repo and copy the Nat file.

[Class7-notes/110225/4-nat.tf at main · aaron-dm-mcdonald/Class7-notes](https://github.com/aaron-dm-mcdonald/Class7-notes/blob/main/110225/4-nat.tf)

Edit any necessary names or ID’s and Terraform IPAD.

12.) Create a 5-RTB file. (Route Tables) From Aarons repo copy the RTB file. [Class7-notes/110225 at main · aaron-dm-mcdonald/Class7-notes](https://github.com/aaron-dm-mcdonald/Class7-notes/tree/main/110225)

Edit VPC IDs, Subnet ID’s and names as necessary to match your Network, then Terraform IPAD.

13.) Create a 6b-SG terraform file Go to  [aws_security_group | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) . Copy the Basic usage code.  Add it to your SG file.

Comment out all Rules, Edit names, ID’s and do an IPAD to get your SG up.

Next Un comment your ingress rules, you will need one for SSH, and HTTP

Add an argument for referenced Security group ID  “ To target your Load Balancer SG” under your HTTP rule.

Edit Names, ID’s, ports. Then IPAD

Add your single egress rule.

14.) Create a 6a-ALB-SG Terraform file. Go to [aws_security_group | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group). Copy basic usage. Add to your ALB SG file.

Edit Resource name and VPC ID. Comment out all rules, then IPAD. To create the ALB-SG in AWS

add one ingress rule Http , and one Egress rule for all. Edit relevant Names and ID’s.

IPAD.

15.) Go back to your first SG, and add your ALB-SG id for referrenced security group ID. IPAD

16.) Create a 7-template terraform file. Go to 

[Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)

only copy the Resource tags.

```
resource "aws_launch_template" "foo" {
  name = "foo"
  }

```

In the documentation find arguments for, 

Description

AMI- has to match the ID for the region your working in

Instance type - t3.Micro

vpc_security_group_IDs = ALB_SG

User data- to call up [user.data.sh](http://user.data.sh) file you need the filebase64 command

add lifecycle argument create_before_destroy = True

Create a user_data.sh file and load your script.

Terraform IPAD

17. Create 8-TG Terraform file.  To create your ALB Target Group go to [aws_lb_target_group | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) . Copy the instance Example from the documentation. Find arguments for Health Checks. Edit necessary names, ID’s. IPAD

18. Create 10a-Load_Balancer terraform file. To create the load balancer go to [aws_lb | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) . Copy the Application load balancer Example. Add to your Tf file. 
    
    Edit your names, SG ID, add your “Public” subnets, Deletion protection to false. IPAD
    
19. Create 10b-Lb-listener terraform file. Go to [aws_lb_listener | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener). Copy the Forward action argument. Add to your listener file.
    
    Delete the certificate Arn, and the ssl policy arguments. Edit prt to 80, protocol to http, Edit necessary arn’s. IPAD
    
20. Create 9-ASG terraform file. Go to [aws_autoscaling_group | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group). Scroll to the with latest version example. Copy all of the second resource block. Add to file.
    
    Remove availability zones argument, Replace with VPC zone identifier Add add your private subnet ID’s to this argument.
    
    Comment out Desired capacity
    
    Min =3
    
    Max= 9
    
    Health check type = “ELB”
    
    Version =$Latest (case sensitive)
    
    add target group arn argument= Target your ALB TG 
    
    Edit necessary names and Arns
    
    add tag{
    
    key=”name”
    
    value= “web instance”
    
    Propagate at launch = true
    
    }
    
    add Forced delete= True   
    
    IPAD
    
    21. Create an 11-scaling_policy terraform file. Go to [aws_autoscaling_policy | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy). Copy the first resource block, remove everything except, name and auto scaling group name .
        
         add argument estimated instance warmup = 60
        
        add argument policy_type = “targettrackingscaling”
        
        Target tracking config
        
        predifined metric_type = “ASGAverageCPUUtilization”
        
        targe_value =40
        
        IPAD
        
    22. Create a 12-attachment terraform file. Go to [aws_autoscaling_attachment | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment). Copy ALB example, and add to your Attachment terraform file. Edit necessary, names ID’s, Arn’s. IPAD