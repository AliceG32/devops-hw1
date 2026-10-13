# devops-hw1
## Шаги для запуска проекта

### Шаг 1 Клонирование репозитория
```bash
git clone https://github.com/AliceG32/devops-hw1.git
cd <название_папки_проекта>
```

---

### Шаг 2. Terraform

Перейдите в директорию `terraform/`:
```bash
cd terraform

terraform init

terraform apply

```


Проверка состояния:
```bash
terraform state list

```

### Шаг 3. Ansible

1. Перейдите в директорию `ansible/`:
```bash
cd ../ansible

```


2. Отредактируйте файл `inventory.ini`, указав IP-адрес вашей виртуальной машины, пользователя и путь к SSH-ключу.
3. Запустите Ansible-плейбук:
```bash
ansible-playbook -i inventory.ini setup_host.yml

```


4. Проверка идемпотентности: Запустите плейбук повторно, все задачи должны завершиться со статусом `changed=0`.

---

### Шаг 4. Запуск Docker Compose

1. Подключитесь к вашей удаленной виртуальной машине по SSH:
```bash
ssh student@<IP_адрес_вашей_ВМ>

```


2. Перейдите в папку с конфигурацией Docker Compose (например, `/opt/app`):
```bash
cd /opt/app

sudo docker compose up -d

```


3. Проверьте статус запущенных контейнеров:
```bash
sudo docker compose ps

```



---

### Шаг 5. Проверка работоспособности

Проверьте работу через `curl`:
```bash
curl -i http://<IP_адрес_вашей_ВМ>

```

## Итоги 
скрины находятся в папке screens
