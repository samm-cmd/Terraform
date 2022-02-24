terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.20.0"
    }
  }
}

# Add Provider = Github
provider "github" {
  # Configuration options
  token = ""
}

# Create new resource
resource "github_repository" "example" {
  name       = "Terraform-Repo"
  visibility = "private"

}
