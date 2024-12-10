provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Update this to your desired AMI
  instance_type = "t2.micro"

  tags = {
    Name = "MusicBandBookingApp"
  }
}
