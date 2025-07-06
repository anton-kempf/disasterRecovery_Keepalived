#!/bin/bash

PORT=80
FILE=/var/www/html/index.nginx-debian.html

# Проверка доступности порта 80 (локально)
if ! nc -z -w 2 127.0.0.0 $PORT; then
  exit 1
fi

# Проверка наличия index.html
if [ ! -f "$FILE" ]; then
  exit 2
fi

# Всё хорошо
exit 0
