Замените `<aws_account_value>`, `<aws_region_value>`, `<list_of_target_namespaces>` и `<secret_copier_value>` на фактические значения, которые вы хотите использовать в вашем CronJob.

- `AWS_ACCOUNT` должен содержать идентификатор вашего AWS аккаунта.
- `AWS_REGION` должен указывать регион AWS, в котором вы работаете.
- `TARGET_NAMESPACES` должен содержать список Kubernetes пространств имен, разделенных запятыми, куда будет копироваться секрет.
- `SECRET_COPIER` должен быть "true" если вы хотите использовать копирование секретов, или "false" в противном случае.
---
Replace `<aws_account_value>`, `<aws_region_value>`, `<list_of_target_namespaces>`, and `<secret_copier_value>` with the actual values you wish to use in your CronJob.

- `AWS_ACCOUNT` should contain your AWS account ID.
- `AWS_REGION` should specify the AWS region you are operating in.
- `TARGET_NAMESPACES` should contain a comma-separated list of Kubernetes namespaces where the secret will be copied to.
- `SECRET_COPIER` should be "true" if you want to use secret copying, or "false" otherwise.
