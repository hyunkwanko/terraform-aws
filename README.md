## Terraform

```
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

```
sudo su -
apt update
apt install nginx
systemctl status nginx

sudo chmod 2775 /var/www
cd /var/www/html
vi index.nginx-debian.html

service nginx restart
```