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
#Create an S3 Bucket: create an S3 bucket to store the Terraform state files
# replace "your-unique-bucket-name" with a unique name for your bucket.
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "your-unique-bucket-name"
  
  tags = {
  Name        = "My bucket"
  Environment = "Dev"
  }
}

#==============================================================================
#Configure Backend: In Terraform configuration, we configure the backend to use the S3 bucket for storing state. 
#This is typically done in a separate file, such as a backend.tf file:
#Optional Step: Locking: Replace "your-dynamodb-table-name" with the name of your DynamoDB table.
terraform {
  backend "s3" {
    bucket         = "your-unique-bucket-name"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        	   = true
    #dynamodb_table = "your-dynamodb-table-name"

    #assume_role_with_web_identity = {
    #  role_arn           = "arn:aws:iam::PRODUCTION-ACCOUNT-ID:role/Terraform"
    #  web_identity_token = "<token value>"
    #}
  }
}

#==============================================================================
#Actions: 
#Action 001a: Initialize: After configuring the backend,  run terraform init to initialize your Terraform configuration. 
#Action 001B: Apply: apply your changes using terraform apply, Terraform will automatically store the state file in the S3 bucket.
#Action 002a: Access Control: Ensure that AWS credentials have the necessary permissions to read and write to the S3 bucket. 
#Action 002b: Access Control:You should have appropriate IAM roles or users with the s3:PutObject and s3:GetObject permissions for the bucket.
#Action 003a: Optional Step: Locking: Optionally, we can configure state locking to prevent concurrent operations that could lead to conflicts. 
#Action 003b: Optional Step: Locking: we can use DynamoDB for state locking, and we can configure it in the same backend.tf file as the S3 backend configuration.
#Action 003c: Optional Step: Locking: Replace "your-dynamodb-table-name" with the name of your DynamoDB table.
#terraform {
#  backend "s3" {
#    # ... (previous config)
#    dynamodb_table = "your-dynamodb-table-name"
#  }
#}



