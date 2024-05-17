## Terraform

K8s Cluster 구축
- AWS Infra Provisioning (Terraform)

```
# 기본 명령어
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
$Env:TF_LOG="DEBUG"
$Env:TF_LOG_PATH="tmp/terraform.log"
```

```
vi key.pem
sudo chmod 600 key.pem
ssh -i key.pem ubuntu@{ip}
```