# Инструкция по использованию скрипта entrypoint.sh

Этот скрипт предназначен для создания или обновления Docker секретов в указанных Kubernetes пространствах имен, используя учетные данные AWS ECR.

## Переменные окружения

- `AWS_ACCESS_KEY_ID`: ID вашего ключа для доступа к api aws
- `AWS_SECRET_ACCESS_KEY`: Secert вашего ключа для доступа к api aws
- `AWS_ACCOUNT`: ID вашего AWS аккаунта.
- `AWS_REGION`: Регион AWS, в котором находится ваш ECR репозиторий.
- `TARGET_NAMESPACES`: Список пространств имен, разделенных запятыми, в которых должен быть создан или обновлен секрет. Если переменная не установлена, используется пространство имен `default`.
- `SECRET_COPIER`: Если установлено в `true`, аннотации и метки для копирования секретов будут применяться только к секрету в пространстве имен `default`.

## Использование

1. Экспортируйте необходимые переменные окружения:

    ```sh
    export AWS_ACCESS_KEY_ID=<ваш_aws_key_id>
    export AWS_SECRET_ACCESS_KEY=<ваш_aws_secret_key>
    export AWS_ACCOUNT=<ваш_aws_account_id>
    export AWS_REGION=<ваш_aws_region>
    export TARGET_NAMESPACES=<список_пространств_имен>
    export SECRET_COPIER=true # опционально
    ```

## Примечания

- Ваш AWS user должен иметь права на выполнение ecr:GetAuthorizationToken.

- Убедитесь, что у вас есть достаточные разрешения для выполнения команд в указанных пространствах имен.
- Если `SECRET_COPIER` не установлена или установлена не в `true`, аннотации и метки для копирования секретов не будут применены.
- Примеры манифестов для Kubernetes можно найти в папке `example`.

---
# Instructions for Using the entrypoint.sh Script

This script is designed to create or update Docker secrets in specified Kubernetes namespaces using AWS ECR credentials.

## Environment Variables

- `AWS_ACCESS_KEY_ID`: Your AWS account key ID
- `AWS_SECRET_ACCESS_KEY`: Your AWS account key secret
- `AWS_ACCOUNT`: Your AWS account ID.
- `AWS_REGION`: The AWS region where your ECR repository is located.
- `TARGET_NAMESPACES`: A comma-separated list of namespaces where the secret should be created or updated. If the variable is not set, the `default` namespace is used.
- `SECRET_COPIER`: If set to `true`, annotations and labels for secret copying will only be applied to the secret in the `default` namespace.

## Usage

1. Export the necessary environment variables:

    ```sh
    export AWS_ACCESS_KEY_ID=<your_aws_key_id>
    export AWS_SECRET_ACCESS_KEY=<your_aws_secret_key>
    export AWS_ACCOUNT=<your_aws_account_id>
    export AWS_REGION=<your_aws_region>
    export TARGET_NAMESPACES=<list_of_namespaces>
    export SECRET_COPIER=true # optional
    ```

## Notes

- You must have ecr:GetAuthorizationToken permission in your aws user.

- Ensure you have sufficient permissions to execute commands in the specified namespaces.
- If `SECRET_COPIER` is not set or not set to `true`, annotations and labels for secret copying will not be applied.
- Examples of Kubernetes manifests can be found in the `example` folder.
