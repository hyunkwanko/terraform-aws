## Terraform

K8s Cluster 구축
- AWS Infra Provisioning (Terraform)

![architecture_2](https://github.com/hyunkwanko/terraform-aws/assets/39941580/271061f8-d948-419b-9b52-4eed68cf6877)

```
// 기본 명령어
* terraform init
* terraform plan
* terraform apply
* terraform destroy
```

```
// AWS IAM 정보
$Env:AWS_ACCESS_KEY_ID=""
$Env:AWS_SECRET_ACCESS_KEY=""
```

```
// Terraform Log
$Env:TF_LOG="DEBUG"
$Env:TF_LOG_PATH="tmp/terraform.log"
```

```
// ssh 접속
vi key.pem
sudo chmod 600 key.pem
ssh -i key.pem ubuntu@{ip}
```