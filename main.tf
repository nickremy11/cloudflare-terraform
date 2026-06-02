terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
 #API Token will be CLOUDFLARE_API_TOKEN env variable
}

variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
  sensitive   = true
}

variable "account_id" {
  description = "Cloudlare account ID"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "Domain name"
  type        = string
  default = "remydemo.com"
}

resource "cloudflare_dns_record" "aaa" {
  zone_id = "var.zone_id"
  name    = "a"
  content = "200.100.11.13"
  type    = "A"
  ttl     = 1
  proxied = true
  comment = "Domain verification record"
}
