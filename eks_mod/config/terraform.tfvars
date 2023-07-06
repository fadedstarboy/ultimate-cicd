
aws_eks_cluster_config = {

      "demo-cluster" = {

        eks_cluster_name         = "demo-cluster1"
        eks_subnet_ids = ["subnet-0f647dfb863afba0e","subnet-02d81219a2fc75faa","subnet-03bdb71a8a78ebbeb","subnet-05740dcebee55ec71"]
        tags = {
             "Name" =  "demo-cluster"
         }  
      }
}

eks_node_group_config = {

  "node1" = {

        eks_cluster_name         = "demo-cluster"
        node_group_name          = "mynode"
        nodes_iam_role           = "eks-node-group-general1"
        node_subnet_ids          = ["subnet-0f647dfb863afba0e","subnet-02d81219a2fc75faa","subnet-03bdb71a8a78ebbeb","subnet-05740dcebee55ec71"]

        tags = {
             "Name" =  "node1"
         } 
  }
}
