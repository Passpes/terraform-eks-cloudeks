# terraform-eks-cloudeks

The sample architecture introduced here includes the following resources:

* EKS Cluster: AWS managed Kubernetes cluster of master servers
* AutoScaling Group containing 2 t2.small instances 
* Associated VPC, Internet Gateway, Security Groups, and Subnets: Operator managed networking resources for the EKS Cluster and worker node instances
* Associated IAM Roles and Policies: Operator managed access resources for EKS and worker node instances

## deploying EKS on AWS using terraform:
```bash
terraform init
terraform deploy
```


### Install folowing tools:
Requirements after deployment to manage K8s Cluster

 * [AWS Client Install](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
 * [Kubernetes Client Install Guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
 * [AWS IAM Authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator)

## Following command allow you to manage EKS using Kubectl:

```bash
terraform output kubeconfig > ~/.kube/config
terraform output config_map_aws_auth > aws-auth.yaml
kubectl apply -f aws-auth.yml
```

### Verify kubectl config using following command:

```bash
kubectl config view
```

Now you can manage EKS cluster using Kubectl..

## Useful commands:

### Kubectl
```bash
kubectl get namespaces
kubectl get nodes
kubectl get svc
```

### AWS CLI
```bash
aws sts get-caller-identity
aws eks describe-cluster --name terraform-eks-cloudeks --query cluster.certificateAuthority.data --output text
aws eks update-kubeconfig --name terraform-eks-cloudeks
```