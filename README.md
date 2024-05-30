## Terraform

K8s Cluster 구축
- AWS Infra Provisioning (Terraform)
- [블로그](https://taronko.tistory.com/45)

![Slide2](https://github.com/hyunkwanko/terraform-aws/assets/39941580/a124fdfc-e134-49d9-8d84-049a4e7f77d7)

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
ssh -i key.pem ubuntu@{Worker Node Internal IP}
```