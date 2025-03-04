terraform {
  backend "s3" {
    bucket = "myawsbucket-jenkinsterraform"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"

  }
}