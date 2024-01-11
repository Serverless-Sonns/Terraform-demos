resource "aws_instance" "terra_instance" {
  vpc_security_group_ids = [data.terraform_remote_state.staging_vpc.outputs.sg_id]
  ami = "ami-0005e0cfe09cc9050"
  subnet_id = data.terraform_remote_state.staging_vpc.outputs.subnet_id
  instance_type = "t2.micro"
  user_data = "${file("user-data.sh")}"
  tags  ={
    Name = "stage-terra-ec2"
  }
}

data "terraform_remote_state" "staging_vpc" {
    backend = "s3"
    config = {
      bucket         = "terraform-backend-test-vishallas"
      key            = "stage/vpc/terraform.tfstate"
      region         = "us-east-1"
    }
}