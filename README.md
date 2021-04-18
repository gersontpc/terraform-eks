# terraform-eks


### Primeiro configure o seu provider utilizando o <u>AWS CLI</u>.

Link para download: [clique aqui!](https://aws.amazon.com/pt/cli/)

Após baixar configure a sua Secret Key e Access Key da AWS:

```shellscript
$ cd ~

$ vim .aws/credentials
 [awsgerson]
 aws_access_key_id = ********************
 aws_secret_access_key = ****************************************
 region = us-west-2

```

Utilizei dessa forma para que você possa criar profiles diferentes e referenciar somente o profile dentro do bloco providers do terraform, dessa forma fica mais segura, pois ele vai pegar o seu profile de dentro do diretório de configuração do AWS CLI.

### Entendendo a estrutura de diretórios:

```shellscript
.
├─ eks-ec2
└─ eks-fargate
  ├── main.tf               >> Configurações do cluster EKS Fargate utilizando módulo;
  ├── provider.tf           >> Configuração do seu provider (AWS, Região e Profile);
  ├── sg.tf                 >> Configurações de Security Group
  ├── state.tf              >> Configurações para armazenar o tfstate em um Bucket S3;
  ├── terraform.tfvars      >> Variáveis (chave e valor);
  ├── variables.tf          >> Declaração das variáveis;
  └── vpc.tf                >> Configuração de VPC (Subnet, IGW)
```

### Criando um Cluster EKS Fargate:

Para criar a infraestrutura do EKS é preciso executar o terraform init dentro do diretório para baixar os módulos:

```shellscript
$ terraform init

Initializing modules...
Downloading terraform-module/eks-fargate-profile/aws 2.2.0 for eks_fargate...
- eks_fargate in .terraform/modules/eks_fargate

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Installing hashicorp/aws v3.37.0...
- Installed hashicorp/aws v3.37.0 (signed by HashiCorp)

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```

After download modules, we will execute the terraform plan command, to view all the resources that will be created.


```shellscript
$ terraform plan

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eks_cluster.eks_cluster will be created
  + resource "aws_eks_cluster" "eks_cluster" {
      + arn                       = (known after apply)
      + certificate_authority     = (known after apply)
      + created_at                = (known after apply)
      + enabled_cluster_log_types = [
          + "api",
          + "audit",
          + "authenticator",
          + "controllerManager",
          + "scheduler",
        ]
      + endpoint                  = (known after apply)
      + id                        = (known after apply)
      + identity                  = (known after apply)
      + name                      = "LabEKSFargate"
      + platform_version          = (known after apply)
      + role_arn                  = (known after apply)
      + status                    = (known after apply)
      + tags                      = {
          + "ENV" = "dev"
        }
      + version                   = "1.18"

      + kubernetes_network_config {
          + service_ipv4_cidr = (known after apply)
        }

      + timeouts {
          + delete = "30m"
        }

      + vpc_config {
          + cluster_security_group_id = (known after apply)
          + endpoint_private_access   = false
          + endpoint_public_access    = true
          + public_access_cidrs       = (known after apply)
          + subnet_ids                = (known after apply)
          + vpc_id                    = (known after apply)
        }
    }

  # aws_iam_role.eks_cluster_role will be created
  + resource "aws_iam_role" "eks_cluster_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = [
                              + "eks.amazonaws.com",
                              + "eks-fargate-pods.amazonaws.com",
                            ]
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "Allow cluster to manage node groups, fargate nodes and cloudwatch logs"
      + force_detach_policies = true
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "LabEKSFargate-cluster-role"
      + path                  = "/"
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # aws_iam_role_policy_attachment.AmazonEKSClusterPolicy1 will be created
  + resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy1" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      + role       = "LabEKSFargate-cluster-role"
    }

  # aws_iam_role_policy_attachment.AmazonEKSVPCResourceController1 will be created
  + resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController1" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
      + role       = "LabEKSFargate-cluster-role"
    }

  # aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + vpc_id   = (known after apply)
    }

  # aws_security_group.testing will be created
  + resource "aws_security_group" "testing" {
      + arn                    = (known after apply)
      + description            = "Security Group for EKS Fargate cluster"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "10.10.0.0/22",
                ]
              + description      = "HTTP from VPC"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "eks-fargate-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "Habilita o HTTP"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.private will be created
  + resource "aws_subnet" "private" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-west-2b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.10.1.0/26"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "eks-fargate-private - 10.10.1.0/26"
        }
      + tags_all                        = {
          + "Name" = "eks-fargate-private - 10.10.1.0/26"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.public will be created
  + resource "aws_subnet" "public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-west-2a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.10.0.0/26"
      + id                              = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "eks-fargate-public - 10.10.0.0/26"
        }
      + tags_all                        = {
          + "Name" = "eks-fargate-public - 10.10.0.0/26"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.main will be created
  + resource "aws_vpc" "main" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.10.0.0/22"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "EKS-Cluster-Fargate"
        }
      + tags_all                         = {
          + "Name" = "EKS-Cluster-Fargate"
        }
    }

Plan: 9 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

Após executar o terraform plan, repare que terá o `+` em cada recurso que será criado.

Agora iremos criar utilizando o `terraform apply --auto-approve`

```shellscript
aws_iam_role.eks_cluster_role: Creating...
aws_vpc.main: Creating...
aws_iam_role.eks_cluster_role: Creation complete after 3s [id=LabEKSFargate-cluster-role]
aws_iam_role_policy_attachment.AmazonEKSClusterPolicy1: Creating...
aws_iam_role_policy_attachment.AmazonEKSVPCResourceController1: Creating...
aws_iam_role_policy_attachment.AmazonEKSVPCResourceController1: Creation complete after 2s [id=LabEKSFargate-cluster-role-20210418230304886200000002]
aws_iam_role_policy_attachment.AmazonEKSClusterPolicy1: Creation complete after 2s [id=LabEKSFargate-cluster-role-20210418230304847100000001]
aws_vpc.main: Still creating... [10s elapsed]
aws_vpc.main: Still creating... [20s elapsed]
aws_vpc.main: Creation complete after 24s [id=vpc-04abbc353fd3dd869]
aws_internet_gateway.gw: Creating...
aws_subnet.private: Creating...
aws_subnet.public: Creating...
aws_security_group.testing: Creating...
aws_subnet.private: Creation complete after 3s [id=subnet-0d5d894f3e4281745]
aws_internet_gateway.gw: Creation complete after 5s [id=igw-0010b0286e2cae328]
aws_security_group.testing: Creation complete after 8s [id=sg-0cb942e0a2bf6d8ad]
aws_subnet.public: Still creating... [10s elapsed]
aws_subnet.public: Creation complete after 15s [id=subnet-0036301a6ea7fcfbc]
aws_eks_cluster.eks_cluster: Creating...
aws_eks_cluster.eks_cluster: Still creating... [10s elapsed]
aws_eks_cluster.eks_cluster: Still creating... [20s elapsed]
aws_eks_cluster.eks_cluster: Still creating... [30s elapsed]
aws_eks_cluster.eks_cluster: Still creating... [40s elapsed]
aws_eks_cluster.eks_cluster: Still creating... [50s elapsed]
aws_eks_cluster.eks_cluster: Still creating... [1m0s elapsed]
...
aws_eks_cluster.eks_cluster: Still creating... [9m0s elapsed]
aws_eks_cluster.eks_cluster: Still creating... [9m10s elapsed]
aws_eks_cluster.eks_cluster: Creation complete after 9m11s [id=LabEKSFargate]
```