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

### Estrutura dos módulos:

```shellscript
.
├─ eks-ec2
└── eks-fargate
    ├── modules
    │   ├── master                          >>  Módulo para criar o cluster
    │   │   ├── cloudwatch.tf
    │   │   ├── cluster.tf
    │   │   ├── output.tf
    │   │   ├── roles.tf
    │   │   ├── sg.tf
    │   │   └── variables.tf
    │   ├── network                         >>  Módulo para criar toda a rede
    │   │   ├── igw.tf
    │   │   ├── nat_gw.tf
    │   │   ├── output.tf
    │   │   ├── private.tf
    │   │   ├── public.tf
    │   │   ├── variables.tf
    │   │   └── vpc.tf
    │   └── nodes                           >> Módulo para criar o node group
    │       ├── fg_profile.tf
    │       ├── node_group.tf
    │       ├── roles.tf
    │       └── variables.tf
    ├── modules.tf                          >> Declara os módulos que iremos utilizar acima
    ├── provider.tf                         >> Provider aws + profile
    ├── state.tf                            >> Terraform state enviado para o S3
    ├── terraform.tfvars                    >> Declaração das variáveis 
    └── variables.tf                        >> Variáveis
```

### Criando um Cluster EKS Fargate:

Antes iremos validar o código do terraform
```sh
$ terraform validate
```


Para criar a infraestrutura do EKS é preciso executar o terraform init dentro do diretório para baixar os módulos:

```sh
$ terraform init
```

Após o download dos providers dos recursos dos módulos, vamos realizar o terraform plan, para ver todos os recursos que serão criados na AWS.


```sh
$ terraform plan
```

Após executar o terraform plan, repare que terá o `+` em cada recurso que será criado.

Agora iremos criar utilizando o `terraform apply --auto-approve`

```sh
$ terraform apply --auto-approve

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
Agora iremos adicionar o contexto do nosso cluster ao kubectl
```sh
aws eks --region us-west-2 update-kubeconfig --name eks-fargate
```
Listando os nodes

```sh
kubectl get nodes
```