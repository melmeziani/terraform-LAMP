variable "instance_region" {
  default = "eu-west-1"
}

variable "images" {
  type = map(string)
  default = {
    "us-east-1"      = "ami-0937dcc711d38ef3f"
    "us-east-2"      = "ami-04328208f4f0cf1fe"
    "us-west-1"      = "ami-0799ad445b5727125"
    "us-west-2"      = "ami-032509850cf9ee54e"
    "ap-south-1"     = "ami-0937dcc711d38ef3f"
    "ap-northeast-2" = "ami-018a9a930060d38aa"
    "ap-southeast-1" = "ami-04677bdaa3c2b6e24"
    "ap-southeast-2" = "ami-0c9d48b5db609ad6e"
    "ap-northeast-1" = "ami-0d7ed3ddb85b521a6"
    "ca-central-1"   = "ami-0de8b8e4bc1f125fe"
    "eu-central-1"   = "ami-0eaec5838478eb0ba"
    "eu-west-1"      = "ami-0862aabda3fb488b5"
    "eu-west-2"      = "ami-0664a710233d7c148"
    "eu-west-3"      = "ami-0854d53ce963f69d8"
    "eu-north-1"     = "ami-6d27a913"
  }
}

variable "web_security_group" {
    type = list
}

variable "public_subnet" {
    type = string
}