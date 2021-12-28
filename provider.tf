terraform {
	required_providers {
		digitalocean = {
			source = "digitalocean/digitalocean"
			version = "~> 2.0"
		}
	}
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
	token = var.do_token
}

data "digitalocean_ssh_key" "UbuntuWSL" {
	name = "UbuntuWSL"
}

resource "digitalocean_kubernetes_cluster" "terraform-cluster" {
	name = "terraform-cluster"
	region = "nyc3"
	auto_upgrade = true
	version = "1.21.5-do.0 "

	node_pool {
		name = "node"
		size = "s-1vcpu-2gb"
		auto_scale = true
		min_nodes = 1
		max_nodes = 2
	}
}


