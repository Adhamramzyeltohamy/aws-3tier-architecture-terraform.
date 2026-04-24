terraform {
    backend "s3" {
    bucket         = "terraform-project-bucket12"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lockstate"
    }
}