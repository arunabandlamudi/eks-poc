resource "aws_eks_cluster" "eks" {
  name     = "POC-eks"
  role_arn = aws_iam_role.master.arn


  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    
    public_access_cidrs = [ "0.0.0.0/0" ]
    subnet_ids = [
      aws_subnet.public-1.id,
      aws_subnet.public-2.id,
      aws_subnet.private-1.id,
      aws_subnet.private-2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
  ]

}

