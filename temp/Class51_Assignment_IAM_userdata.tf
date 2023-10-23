#==============================================================================
#typical configuration data
# Define the AWS provider and specify the region
provider "aws" {
  region = "us-east-1"
}

# Create an AWS EC2 instance
resource "aws_instance" "example_instance" {
  ami           = "ami-053b0d53c279acc90" 
  instance_type = "t2.micro"
}

# Output the public IP address of the created EC2 instance
output "public_ip" {
  value = aws_instance.example_instance.public_ip
}

#==============================================================================
#Make sure you have the necessary permissions in your AWS account to create IAM users.
#we will create the Terraform configuration file with following data: 
#1.The provider "aws" block configures the AWS provider with the desired AWS region.
#2. The aws_iam_user resource creates an IAM user with the name "example_user." You can change the name to whatever you prefer.
#3. The aws_iam_access_key resource generates an access key and secret key for the IAM user created in step 2.
#4. The output blocks are used to print the access key and secret key to the console once the Terraform configuration is applied.

#Terraform configuration file data to be saved in a tf file:
provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_iam_user" "example_user" {
  name = "example_user"
}

resource "aws_iam_access_key" "example_user_access_key" {
  user = aws_iam_user.example_user.name
}

output "access_key" {
  value = aws_iam_access_key.example_user_access_key.id
}

output "secret_key" {
  value = aws_iam_access_key.example_user_access_key.secret
}

#==============================================================================
#steps to carry out in bash or cmd command is double commented
#Initialize Terraform:
##terraform init

#Apply the configuration to create the IAM user and keys:
##terraform apply

#destroy the resources created by Terraform
##terraform destroy

