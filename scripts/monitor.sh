#!/bin/bash

if [ -z "$1" ]; then
    echo "Использование: $0 <имя_сервиса>"
    echo "Пример: $0 docker"
    exit 1
fi

SERVICE_NAME="$1"

echo "Проверка статуса сервиса: $SERVICE_NAME"

STATUS=$(systemctl is-active "$SERVICE_NAME" 2>/dev/null)

if [ "$STATUS" = "active" ]; then
    echo "Статус: ACTIVE (Сервис $SERVICE_NAME работает коррекнто)"
else
    echo "Статус: $STATUS (Сервис не активен)"
    echo "Последние 10 строк логов ($SERVICE_NAME)"
    journalctl -u "$SERVICE_NAME" -n 10 --no-pager
fi

echo ""
echo " Анализ ошибок в syslog за последний час"

if [ -f /var/log/syslog ]; then
    CURRENT_DATE=$(date "+%b %e %H")
    ERROR_COUNT=$(grep "$CURRENT_DATE" /var/log/syslog 2>/dev/null | grep -iE "error|fail|critical" | wc -l)
    echo "Количество ошибок за текущий час ($CURRENT_DATE:00): $ERROR_COUNT"
else
    echo "Файл /var/log/syslog не найден или недоступен для чтения без sudo."
fi