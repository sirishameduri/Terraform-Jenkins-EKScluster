terraform {
  backend "s3" {
    bucket = "myawsbucket-jenkinsterraform"
    region = "us-east-1"
    key = "ekscluster.tfstate"
    
  }
}