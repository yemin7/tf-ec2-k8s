<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.70.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key-pair"></a> [key-pair](#module\_key-pair) | terraform-aws-modules/key-pair/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.ec2-sg](https://registry.terraform.io/providers/hashicorp/aws/3.70.0/docs/resources/security_group) | resource |
| [aws_spot_instance_request.ec2_spot](https://registry.terraform.io/providers/hashicorp/aws/3.70.0/docs/resources/spot_instance_request) | resource |
| [local_file.private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_shuffle.private_subnet_ids](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) | resource |
| [random_shuffle.public_subnet_ids](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_value"></a> [az\_value](#input\_az\_value) | Availability Zone | `list(string)` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | AWS KeyPair | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private Subnet IDs | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | Public Subnet IDs | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_spot_instance"></a> [spot\_instance](#input\_spot\_instance) | n/a | <pre>object({<br>    ami                  = string<br>    spot_price           = string<br>    instance_type        = string<br>    spot_type            = string<br>    wait_for_fulfillment = bool<br>    internal             = bool<br>    num_of_instance      = number<br>  })</pre> | n/a | yes |
| <a name="input_target_group"></a> [target\_group](#input\_target\_group) | n/a | <pre>object({<br>    port        = number<br>    protocol    = string<br>    target_type = string<br>    health_check = object({<br>      path     = string<br>      protocol = string<br>      port     = number<br>    })<br>  })</pre> | <pre>{<br>  "health_check": {<br>    "path": "/",<br>    "port": 80,<br>    "protocol": "HTTP"<br>  },<br>  "port": 80,<br>  "protocol": "HTTP",<br>  "target_type": "instance"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | EC2 IDs |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | Private Pem Key |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
<!-- END_TF_DOCS -->


## Sample .tfvars

| Name | Description | Value |
|------|-------------|-------|
| <a name="input_region"></a> [region](#input\_region) | Region | `"ap-southeast-1"` |
| <a name="input_az_value"></a> [az\_value](#input\_az\_value) | Availability Zone | `["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]` |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | AWS KeyPair | `"key_pair"` |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `"vpc-12345678"` |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | Public Subnet IDs | `["subnet-123", "subnet-456", "subnet-789"]` |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private Subnet IDs | `["subnet-987", "subnet-654", "subnet-321"]` |
| <a name="input_spot_instance"></a> [spot\_instance](#input\_spot\_instance) | n/a | <pre>ami = "ami-1234567"<br>instance_type = "t3.medium"<br>spot_price = "0.03"<br>spot_type = "one-time"<br>wait_for_fullfilment = true<br>internal = false<br>num_of_instance = 2</pre> |
| <a name="input_target_group"></a> [target\_group](#input\_target\_group) | n/a | <pre>port = 80<br>protocol = "HTTP"<br>target_type = "instance"<br>health_check = {<br>  path = "/"<br>  protocol = "HTTP"<br>  port = 80<br>}</pre> |