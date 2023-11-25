resource "aws_opensearch_domain" "poc" {
  domain_name = "opensearch-poc"

  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 2
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}
