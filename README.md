![GitHub repo size](https://img.shields.io/github/repo-size/IPHUN1989/go-docker-k8s-tf)
![GitHub language count](https://img.shields.io/github/languages/count/IPHUN1989/go-docker-k8s-tf)
![Static Badge](https://img.shields.io/badge/total%20number%20of%20tracked%20files-19-blue)
![GitHub contributors](https://img.shields.io/github/contributors/IPHUN1989/go-docker-k8s-tf)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/t/IPHUN1989/go-docker-k8s-tf?label=total%20commits)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/m/IPHUN1989/go-docker-k8s-tf?label=monthly%20commits)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/IPHUN1989/go-docker-k8s-tf/main)
![GitHub closed issues](https://img.shields.io/github/issues-closed/IPHUN1989/go-docker-k8s-tf)
![GitHub issues](https://img.shields.io/github/issues-raw/IPHUN1989/go-docker-k8s-tf)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IPHUN1989/go-docker-k8s-tf)

# Hello World application written in Go with GitHub actions CI tested in K8S environment by using Terraform

**The project uses the following technologies:**

- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/programming%20languages/go.svg" alt="drawing" width="30" align="center"/> _Go_
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/cloud/docker.svg" alt="drawing" width="30" align="center"/> _Docker_
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/cloud/github.svg" alt="drawing" width="30" align="center"/> _GitHub actions_
- <img src="https://www.svgrepo.com/show/376331/kubernetes.svg" alt="drawing" width="30" align="center"/> _Kubernetes_
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/master/cloud/terraform.png" alt="drawing" width="30" align="center"/> _Terraform_

# Background

**A mini project where the goal was to simulate an environment where the following happens:**

- *Application written in Go*
- *Application is dockerized*
- *Whenever there is a push to the project's repository a docker image is built pushed to DockerHub*
- *Kubernetes resources are using the latest image to run it in a cluster*
- *Terraform is using kubernetes resource files to interact with the given cluster and deploy them there*
- *A script is provided to let the user choose between local testing (Minikube) or cloud testing (AWS)*

# Prerequisites

- <img src="https://upload.wikimedia.org/wikipedia/commons/4/4b/Bash_Logo_Colored.svg" alt="drawing" width="30" align="center"/> *Bash*
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/master/cloud/terraform.png" alt="drawing" width="30" align="center"/> <a href="https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli" target="_blank">*Terraform*</a>
- <img src="https://www.svgrepo.com/show/373296/minikube.svg" alt="drawing" width="30" align="center"/> <a href="https://minikube.sigs.k8s.io/docs/start/" target="_blank">*Minikube (Local)*</a>
- <img src="https://raw.githubusercontent.com/eksctl-io/eksctl/main/logo/eksctl.png" alt="drawing" width="30" align="center"/> <a href="https://eksctl.io/installation/" target="_blank">*aws cli (Cloud)*</a>
- <img src="https://buddy.works/_next/image?url=%2Fblog%2Fthumbnails%2Faws-cli-cover.png&w=750&q=75" alt="drawing" width="30" align="center"/> <a href="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html" target="_blank">*aws cli (Cloud)*</a>


# Usage

## Local test with Minikube

```bash
# Please be aware that minikube tunnel requires root privileges, so if you are running it as a non root user be prepared to enter your sudo password, unless you have paswordless sudo configured

# Navigate to the terraform folder
./provision.sh --minikube

# Check the application 
kubectl get svc -n go-web-server

# You can visit the hello on the external IP

# If you do not wish to use anymore the application you can use the following command:
terraform destroy
```

## Cloud test with AWS EKS

```bash
# Fill out the requested variable in the /terraform/terraform.tfvars

# Please note that cluster name can be changed to your desire but it has to match with the cluster name in the eksctl_cluster.yaml

# Navigate to the main folder and start the cluster with
eksctl create cluster -f ./eksctl_cluster.yaml 

# Update the kubeconfig manually
aws eks update-kubeconfig --name my-cluster --region eu-central-1

# Once it is done creating a cluster in EKS then navigate to terraform folder
./provision.sh --aws

# Check the application 
kubectl get svc -n go-web-server

# You can visit the hello on the external IP

# If you do not wish to use anymore the application you can use the following command:
terraform destroy

# If you do not wish to use the provisioned cluster then please run the following command in the main folder:
eksctl delete cluster -f ./eksctl_cluster.yaml --disable-nodegroup-eviction
```
