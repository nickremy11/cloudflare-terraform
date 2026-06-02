terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
#AAA
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

# Enable TLS 1.3
resource "cloudflare_zone_setting" "tls_1_3" {
  zone_id    = var.zone_id
  setting_id = "tls_1_3"
  value      = "on"
}

# Enable automatic HTTPS rewrites
resource "cloudflare_zone_setting" "automatic_https_rewrites" {
  zone_id    = var.zone_id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}

# Set SSL mode to strict
resource "cloudflare_zone_setting" "ssl" {
  zone_id    = var.zone_id
  setting_id = "ssl"
  value      = "strict"
}

resource "cloudflare_ruleset" "zone_custom_firewall" {
  zone_id     = var.zone_id
  name        = "Phase entry point ruleset for custom rules in my zone"
  description = ""
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [{
    ref         = "block_non_default_ports"
    description = "Block ports other than 80 and 443"
    expression  = "(not cf.edge.server_port in {80 443})"
    action      = "block"
  }]
}