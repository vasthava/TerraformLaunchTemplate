terraform {
  backend "s3"{
    bucket = "batman-tf-bucket"
    region ="us-east-2"
    key = "terraform_instancetemplate.tfstate"
  }
}