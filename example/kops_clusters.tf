################################################################################
# Cluster using public subnets

module "staging" {
  source                    = "../module"
  kubernetes_version        = "1.8.11"
  sg_allow_ssh              = "${aws_security_group.allow_ssh.id}"
  sg_allow_http_s           = "${aws_security_group.allow_http.id}"
  cluster_name              = "cluster1"
  cluster_fqdn              = "cluster1.${aws_route53_zone.k8s_zone.name}"
  route53_zone_id           = "${aws_route53_zone.k8s_zone.id}"
  kops_s3_bucket_arn        = "${aws_s3_bucket.kops.arn}"
  kops_s3_bucket_id         = "${aws_s3_bucket.kops.id}"
  vpc_id                    = "${aws_vpc.main_vpc.id}"
  instance_key_name         = "Jag"
  node_asg_desired          = 2
  node_asg_min              = 2
  node_asg_max              = 2
  master_instance_type      = "t2.large"
  node_instance_type        = "t2.large"
  internet_gateway_id       = "${aws_internet_gateway.public.id}"
  public_subnet_cidr_blocks = ["${local.cluster1_public_subnet_cidr_blocks}"]
  kops_dns_mode             = "private"
}

resource "random_id" "s3_suffix" {
  byte_length = 3
}

resource "aws_s3_bucket" "kops" {
  bucket        = "kops-state-store-${random_id.s3_suffix.dec}"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
}
