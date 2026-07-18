provider "aws" {
  region = "ap-south-1"
}

provider "aws" {       #this is the example of provider aliasing, we can use this to create resources in different regions
  alias  = "singapore"
  region = "ap-southeast-1"
}