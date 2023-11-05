resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name = aws_eks_cluster.eks.name
  fargate_profile_name = "kube-system"
  pod_execution_role_arn = aws_iam_role.worker.arn
  selector {
    namespace = "kube-system"
  }
  subnet_ids = [ 
    aws_subnet.private-1.id,
    aws_subnet.private-2.id
   ]
}